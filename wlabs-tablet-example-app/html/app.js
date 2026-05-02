// Cache DOM elements once at startup so event handlers can reuse them.
const form = document.getElementById('hello-form');
const input = document.getElementById('name-input');
const statusText = document.getElementById('status-text');

// Small UI helper used by both success and error paths.
// The CSS classes control the color; JS only decides the current state.
function setStatus(message, type) {
    statusText.textContent = message;
    statusText.classList.toggle('is-success', type === 'success');
    statusText.classList.toggle('is-error', type === 'error');
}

// Calls a RegisterNUICallback in this resource's Lua script.
// In FiveM, POSTing to https://RESOURCE_NAME/callbackName reaches Lua.
async function nuiCallback(name, data) {
    // GetParentResourceName() exists inside FiveM NUI.
    // The fallback keeps this page easier to preview in a normal browser.
    const resource = typeof GetParentResourceName === 'function'
        ? GetParentResourceName()
        : 'wlabs-tablet-example-app';

    const response = await fetch(`https://${resource}/${name}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(data || {})
    });

    return response.json();
}

form.addEventListener('submit', async (event) => {
    // Keep the browser from reloading the page when the form submits.
    event.preventDefault();
    setStatus('Calling Lua...', '');

    try {
        // Trim keeps accidental spaces out of the payload sent to Lua.
        const result = await nuiCallback('testApp', { name: input.value.trim() });
        setStatus(result.message || 'Hello from WLabs Tablet.', result.ok ? 'success' : 'error');
    } catch (error) {
        // A normal browser cannot reach FiveM's NUI callback endpoint.
        // Seeing this while previewing the HTML outside FiveM is okay.
        setStatus('Could not reach the Lua callback. In a browser preview, this is expected.', 'error');
    }
});

window.addEventListener('message', (event) => {
    // WLabs Tablet can post messages into the iframe.
    // Add your own actions.
    if (event.data && event.data.action === 'close') {
        setStatus('The tablet is closing this app.', '');
    }
});
