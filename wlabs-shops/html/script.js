(function () {
  const shopUi = document.getElementById('shop-ui');
  const shopTitle = document.getElementById('shop-title');
  const shopSlots = document.getElementById('shop-slots');
  const cartSlots = document.getElementById('cart-slots');
  const cartTotalEl = document.getElementById('cart-total');
  const btnClose = document.getElementById('btn-close');
  const btnCheckout = document.getElementById('btn-checkout');
  const checkoutModal = document.getElementById('checkout-modal');
  const checkoutAmount = document.getElementById('checkout-amount');
  const checkoutCancel = document.getElementById('checkout-cancel');
  const quantityModal = document.getElementById('quantity-modal');
  const quantityInput = document.getElementById('quantity-input');
  const quantityConfirm = document.getElementById('quantity-confirm');
  const quantityCancel = document.getElementById('quantity-cancel');

  let shopId = null;
  let shopLabel = '';
  let items = [];
  let imagePath = '';
  let cart = [];
  let shopSearchQuery = '';
  let pendingQuantityItem = null;

  function hexToRgb(hex) {
    if (!hex) return null;
    let s = hex.trim().replace('#', '');
    if (s.length === 3) {
      s = s
        .split('')
        .map(function (c) {
          return c + c;
        })
        .join('');
    }
    if (s.length !== 6) return null;
    const num = parseInt(s, 16);
    if (isNaN(num)) return null;
    return {
      r: (num >> 16) & 255,
      g: (num >> 8) & 255,
      b: num & 255,
    };
  }

  function adjustHex(hex, percent) {
    const rgb = hexToRgb(hex);
    if (!rgb) return hex;
    const factor = (100 + percent) / 100;
    const r = Math.max(0, Math.min(255, Math.round(rgb.r * factor)));
    const g = Math.max(0, Math.min(255, Math.round(rgb.g * factor)));
    const b = Math.max(0, Math.min(255, Math.round(rgb.b * factor)));
    const toHex = function (v) {
      const h = v.toString(16);
      return h.length === 1 ? '0' + h : h;
    };
    return '#' + toHex(r) + toHex(g) + toHex(b);
  }

  function applyUiConfig(ui) {
    if (!ui || !ui.accent) return;
    const root = document.documentElement;
    const accent = ui.accent;
    root.style.setProperty('--accent', accent);

    const rgb = hexToRgb(accent);
    if (rgb) {
      root.style.setProperty(
        '--accent-rgb',
        rgb.r + ', ' + rgb.g + ', ' + rgb.b
      );
    }

    const accentLight = ui.accentLight || adjustHex(accent, 12);
    const accentDark = ui.accentDark || adjustHex(accent, -15);
    if (accentLight) root.style.setProperty('--accent-light', accentLight);
    if (accentDark) root.style.setProperty('--accent-dark', accentDark);
  }

  function getImageUrl(item) {
    const name = (item && item.image) || (item && item.name) || 'placeholder';
    if (imagePath) return imagePath + '/' + name + '.png';
    return 'nui://ox_inventory/web/images/' + name + '.png';
  }

  function getFilteredShopItems() {
    if (!shopSearchQuery.trim()) return items;
    const q = shopSearchQuery.trim().toLowerCase();
    return items.filter(function (item) {
      const name = (item.name || '').toLowerCase();
      const label = (item.label || '').toLowerCase();
      return name.indexOf(q) !== -1 || label.indexOf(q) !== -1;
    });
  }

  function renderShopSlots() {
    shopSlots.innerHTML = '';
    const filtered = getFilteredShopItems();
    filtered.forEach(function (item) {
      const el = document.createElement('div');
      el.className = 'slot shop-slot';
      el.dataset.name = item.name;
      el.dataset.label = item.label || item.name;
      el.dataset.price = item.price;
      el.dataset.image = item.image || item.name;
      el.draggable = true;
      el.innerHTML =
        '<img class="slot-image" src="' +
        getImageUrl(item) +
        '" alt="" onerror="this.style.display=\'none\'">' +
        '<span class="slot-label">' +
        (item.label || item.name) +
        '</span>' +
        '<span class="slot-price">$' +
        item.price +
        '</span>';
      el.addEventListener('dragstart', onShopDragStart);
      shopSlots.appendChild(el);
    });
  }

  function renderCartSlots() {
    cartSlots.innerHTML = '';
    let total = 0;
    cart.forEach(function (line, index) {
      total += line.price * line.count;
      const el = document.createElement('div');
      el.className = 'slot cart-slot';
      el.dataset.index = index;
      el.innerHTML =
        '<img class="slot-image" src="' +
        getImageUrl({ name: line.name, image: line.image }) +
        '" alt="" onerror="this.style.display=\'none\'">' +
        '<span class="slot-label">' +
        (line.label || line.name) +
        '</span>' +
        '<span class="slot-price">$' +
        line.price +
        ' × ' +
        line.count +
        '</span>' +
        '<span class="slot-count">' +
        line.count +
        '</span>';
      el.addEventListener('click', function () {
        cart.splice(index, 1);
        renderCartSlots();
        updateTotal();
      });
      cartSlots.appendChild(el);
    });
    cartTotalEl.textContent = total;
    btnCheckout.disabled = cart.length === 0;
  }

  function updateTotal() {
    let total = 0;
    cart.forEach(function (line) {
      total += line.price * line.count;
    });
    cartTotalEl.textContent = total;
    btnCheckout.disabled = cart.length === 0;
  }

  let draggedShopItem = null;

  function onShopDragStart(e) {
    const slot = e.target.closest('.shop-slot');
    if (!slot) return;
    draggedShopItem = {
      name: slot.dataset.name,
      label: slot.dataset.label,
      price: parseInt(slot.dataset.price, 10),
      image: slot.dataset.image || slot.dataset.name,
    };
    e.dataTransfer.setData('text/plain', slot.dataset.name);
    e.dataTransfer.effectAllowed = 'copy';
  }

  shopSlots.addEventListener('dragover', function (e) {
    e.preventDefault();
    e.dataTransfer.dropEffect = 'copy';
  });

  cartSlots.addEventListener('dragover', function (e) {
    e.preventDefault();
    e.dataTransfer.dropEffect = 'copy';
    e.currentTarget.classList.add('dragover');
  });
  cartSlots.addEventListener('dragleave', function (e) {
    e.currentTarget.classList.remove('dragover');
  });
  cartSlots.addEventListener('drop', function (e) {
    e.preventDefault();
    e.currentTarget.classList.remove('dragover');
    if (!draggedShopItem) return;
    const existing = cart.find(function (l) {
      return l.name === draggedShopItem.name;
    });
    if (existing) {
      existing.count += 1;
    } else {
      cart.push({
        name: draggedShopItem.name,
        label: draggedShopItem.label,
        price: draggedShopItem.price,
        image: draggedShopItem.image,
        count: 1,
      });
    }
    renderCartSlots();
    updateTotal();
    draggedShopItem = null;
  });

  /* Click to add one to cart (alternative to drag) */
  shopSlots.addEventListener('click', function (e) {
    const slot = e.target.closest('.shop-slot');
    if (!slot) return;
    const name = slot.dataset.name;
    const label = slot.dataset.label;
    const price = parseInt(slot.dataset.price, 10);
    const image = slot.dataset.image || name;
    const existing = cart.find(function (l) {
      return l.name === name;
    });
    if (existing) {
      existing.count += 1;
    } else {
      cart.push({ name: name, label: label, price: price, image: image, count: 1 });
    }
    renderCartSlots();
    updateTotal();
  });

  /* Right-click to choose quantity */
  shopSlots.addEventListener('contextmenu', function (e) {
    const slot = e.target.closest('.shop-slot');
    if (!slot || !quantityModal || !quantityInput) return;
    e.preventDefault();
    e.stopPropagation();
    const name = slot.dataset.name;
    const label = slot.dataset.label;
    const price = parseInt(slot.dataset.price, 10);
    const image = slot.dataset.image || name;
    pendingQuantityItem = { name: name, label: label, price: price, image: image };
    quantityInput.value = '';
    quantityInput.min = 1;
    quantityModal.classList.remove('hidden');
    quantityInput.focus();
  });

  function closeQuantityModal() {
    if (!quantityModal) return;
    quantityModal.classList.add('hidden');
    pendingQuantityItem = null;
  }

  if (quantityCancel) {
    quantityCancel.addEventListener('click', function () {
      closeQuantityModal();
    });
  }

  if (quantityConfirm) {
    quantityConfirm.addEventListener('click', function () {
      if (!pendingQuantityItem) {
        closeQuantityModal();
        return;
      }
      let qty = parseInt(quantityInput.value, 10);
      if (isNaN(qty) || qty <= 0) qty = 1;
      const existing = cart.find(function (l) {
        return l.name === pendingQuantityItem.name;
      });
      if (existing) {
        existing.count += qty;
      } else {
        cart.push({
          name: pendingQuantityItem.name,
          label: pendingQuantityItem.label,
          price: pendingQuantityItem.price,
          image: pendingQuantityItem.image,
          count: qty,
        });
      }
      renderCartSlots();
      updateTotal();
      closeQuantityModal();
    });
  }

  if (quantityInput) {
    quantityInput.addEventListener('keydown', function (e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        if (quantityConfirm) quantityConfirm.click();
      } else if (e.key === 'Escape') {
        e.preventDefault();
        closeQuantityModal();
      }
    });
  }

  var shopSearch = document.getElementById('shop-search');
  if (shopSearch) {
    shopSearch.addEventListener('input', function () {
      shopSearchQuery = shopSearch.value;
      renderShopSlots();
    });
  }

  btnClose.addEventListener('click', function () {
    shopUi.classList.add('hidden');
    if (checkoutModal) checkoutModal.classList.add('hidden');
    if (quantityModal) quantityModal.classList.add('hidden');
    fetch('https://wlabs-shops/close', { method: 'POST', body: JSON.stringify({}) }).catch(function () {});
  });

  btnCheckout.addEventListener('click', function () {
    if (cart.length === 0) return;
    const total = cart.reduce(function (s, l) {
      return s + l.price * l.count;
    }, 0);
    checkoutAmount.textContent = '$' + total;
    checkoutModal.classList.remove('hidden');
  });

  checkoutCancel.addEventListener('click', function () {
    checkoutModal.classList.add('hidden');
  });

  document.querySelectorAll('.btn-pay').forEach(function (btn) {
    btn.addEventListener('click', function () {
      const method = btn.getAttribute('data-method');
      checkoutModal.classList.add('hidden');
      fetch('https://wlabs-shops/checkout', {
        method: 'POST',
        body: JSON.stringify({ shopId: shopId, cart: cart, paymentMethod: method }),
      }).catch(function () {});
    });
  });

  window.addEventListener('message', function (event) {
    const data = event.data;
    if (data.action === 'closeShop') {
      shopUi.classList.add('hidden');
      checkoutModal.classList.add('hidden');
      if (quantityModal) quantityModal.classList.add('hidden');
      return;
    }
    if (data.action === 'openShop') {
      shopId = data.shopId;
      shopLabel = data.shopLabel || 'Shop';
      items = data.items || [];
      imagePath = data.imagePath || '';
      cart = [];
      shopSearchQuery = '';
      pendingQuantityItem = null;
      var searchInput = document.getElementById('shop-search');
      if (searchInput) searchInput.value = '';
      applyUiConfig(data.ui || null);
      shopTitle.textContent = shopLabel;
      renderShopSlots();
      renderCartSlots();
      updateTotal();
      shopUi.classList.remove('hidden');
    }
  });
})();
