if Config.Locale ~= 'ar' then return end

Config.Locales = Config.Locales or {}
Config.Locales['ar'] = {
    -- 3D Metin (نصوص ثلاثية الأبعاد)
    take_pump           = '[E] Take Pump',
    return_pump         = '[G] Return Pump',
    open_menu           = '[E] Open Menu',
    remove_pump         = '[G] Remove Pump',
    attach_pump         = '[E] Attach to Vehicle',
    buy_station_text    = '[E] Purchase Station',
    manage_station_text = '[E] Manage Station',

    -- Bildirimler (إشعارات)
    no_money            = 'ليس لديك مال كافٍ!',
    refuel_success      = 'تم تزويد المركبة بالوقود بنجاح.',
    station_bought      = 'لقد اشتريت المحطة!',
    station_sold        = 'لقد بعت المحطة.',
    already_owned       = 'هذه المحطة مملوكة بالفعل.',
    not_owner           = 'أنت لست صاحب هذه المحطة.',
    price_updated       = 'تم تحديث أسعار الوقود.',
    low_fuel            = 'تحذير: مستوى الوقود حرج!',
    engine_stopped      = 'توقف المحرك - نفد الوقود!',
    stock_added         = 'تم إضافة مخزون وقود للمحطة.',
    stock_low           = 'تحذير: مخزون وقود المحطة ينخفض!',
    stock_empty         = 'نفد مخزون وقود المحطة!',
    cash_withdrawn      = 'تم سحب المال من خزينة المحطة.',
    cash_deposited      = 'تم إيداع المال في خزينة المحطة.',

    -- İstasyon UI (واجهة المحطة)
    station_name        = 'اسم المحطة',
    station_owner       = 'المالك',
    station_noowner     = 'للبيع',
    station_buy         = 'شراء المحطة',
    station_sell        = 'بيع المحطة',
    station_manage      = 'إدارة المحطة',
    station_income      = 'إجمالي الدخل',
    station_setprice    = 'ضبط الأسعار',
    station_safe        = 'خزينة المحطة',
    station_stock       = 'مخزون الوقود',
    station_buy_stock   = 'شراء مخزون وقود',
    station_withdraw    = 'سحب المال',
    station_deposit     = 'إيداع المال',
    station_safe_balance= 'رصيد الخزينة',
    station_stock_level = 'مستوى المخزون',
    liters              = 'لتر',

    -- Satın Alma Modalı (نافذة الشراء)
    buy_modal_title     = 'شراء محطة وقود',
    buy_modal_desc      = 'هل تريد شراء هذه المحطة؟',
    buy_modal_price     = 'سعر المحطة',
    buy_modal_confirm   = 'شراء',
    buy_modal_cancel    = 'إلغاء',

    -- Yakıt UI (واجهة الوقود)
    ui_title            = 'أنواع الوقود',
    ui_amount           = 'كمية التعبئة',
    ui_cost             = 'التكلفة التقديرية',
    type_economic       = 'اقتصادي',
    type_normal         = 'عادي',
    type_super          = 'سوبر',
    type_electric       = 'كهربائي',
    pay_cash            = 'كاش',
    pay_bank            = 'بنك',
    info_plate          = 'اللوحة',
    info_fuel           = 'مستوى الوقود',
    info_type           = 'نوع الوقود',
    btn_start           = 'ابدأ تعبئة الوقود',
    btn_refueling       = 'جاري التعبئة...',
    info_owner          = 'المالك',
    info_price          = 'السعر / لتر',
    liter               = 'ل',
    ecoDesc             = 'قوة أقل، مدى أطول',
    normalDesc          = 'أداء واستهلاك قياسي',
    superDesc           = 'للمركبات عالية الأداء',
    elecDesc            = 'شحن للمركبات الكهربائية',
    confirm_title       = 'تأكيد مطلوب',
    confirm_desc        = 'هل أنت متأكد من رغبتك في البيع؟ لا يمكن التراجع عن هذا الإجراء.',
    btn_confirm         = 'تأكيد',
    btn_cancel          = 'إلغاء',
    placeholder_amount  = 'المبلغ ($)',
    placeholder_liters  = 'كمية اللترات',
    btn_withdraw        = 'سحب',
    btn_deposit         = 'إيداع',
    btn_buy             = 'شراء',
    btn_save_prices     = 'حفظ الأسعار',
    hint_safe           = 'يتم استخدام رصيد الخزينة تلقائياً عند الشراء.',
    hint_stock          = 'المخزون الحالي: {current} / {max} ل. يُخصم المال من الخزينة أولاً.',
    sell_warning        = 'إذا بعت المحطة، ستحصل على 70% من السعر ورصيد الخزينة. إجراء لا رجعة فيه.',
    info_sell_value     = 'قيمة البيع: استرداد {percent}%',
    info_start_stock    = 'مخزون الوقود الأولي: {amount} ل',
    info_payments       = 'مدفوعات العملاء تذهب إلى خزينتك',
}

function T(key)
    local lang = Config.Locales[Config.Locale] or Config.Locales['ar']
    return lang[key] or key
end