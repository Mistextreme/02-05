if Config.Locale ~= 'he' then return end

Config.Locales = Config.Locales or {}
Config.Locales['he'] = {
    -- 3D Metin (טקסט תלת-ממדי)
    take_pump           = '[E] Take Pump',
    return_pump         = '[G] Return Pump',
    open_menu           = '[E] Open Menu',
    remove_pump         = '[G] Remove Pump',
    attach_pump         = '[E] Attach to Vehicle',
    buy_station_text    = '[E] Purchase Station',
    manage_station_text = '[E] Manage Station',

    -- Bildirimler (התראות)
    no_money            = 'אין לך מספיק כסף!',
    refuel_success      = 'הרכב תודלק בהצלחה.',
    station_bought      = 'קנית את התחנה!',
    station_sold        = 'מכרת את התחנה.',
    already_owned       = 'תחנה זו כבר נמצאת בבעלות.',
    not_owner           = 'אינך הבעלים של תחנה זו.',
    price_updated       = 'מחירי הדלק עודכנו.',
    low_fuel            = 'אזהרה: רמת הדלק קריטית!',
    engine_stopped      = 'המנוע כבה - נגמר הדלק!',
    stock_added         = 'נוסף מלאי דלק לתחנה.',
    stock_low           = 'אזהרה: מלאי הדלק בתחנה אוזל!',
    stock_empty         = 'מלאי הדלק בתחנה נגמר!',
    cash_withdrawn      = 'נמשך כסף מכספת התחנה.',
    cash_deposited      = 'הופקד כסף בכספת התחנה.',

    -- İstasyon UI (ממשק התחנה)
    station_name        = 'שם התחנה',
    station_owner       = 'בעלים',
    station_noowner     = 'למכירה',
    station_buy         = 'קנה תחנה',
    station_sell        = 'מכור תחנה',
    station_manage      = 'נהל תחנה',
    station_income      = 'הכנסה כוללת',
    station_setprice    = 'הגדר מחירים',
    station_safe        = 'כספת התחנה',
    station_stock       = 'מלאי דלק',
    station_buy_stock   = 'קנה מלאי דלק',
    station_withdraw    = 'משוך כסף',
    station_deposit     = 'הפקד כסף',
    station_safe_balance= 'יתרת כספת',
    station_stock_level = 'רמת מלאי',
    liters              = 'ליטר',

    -- Satın Alma Modalı (חלון רכישה)
    buy_modal_title     = 'רכישת תחנת דלק',
    buy_modal_desc      = 'האם ברצונך לקנות תחנה זו?',
    buy_modal_price     = 'מחיר התחנה',
    buy_modal_confirm   = 'קנה',
    buy_modal_cancel    = 'בטל',

    -- Yakıt UI (ממשק דלק)
    ui_title            = 'סוגי דלק',
    ui_amount           = 'כמות מילוי',
    ui_cost             = 'עלות משוערת',
    type_economic       = 'כלכלי',
    type_normal         = 'רגיל',
    type_super          = 'סופר',
    type_electric       = 'חשמלי',
    pay_cash            = 'מזומן',
    pay_bank            = 'בנק',
    info_plate          = 'מספר רכב',
    info_fuel           = 'רמת דלק',
    info_type           = 'סוג דלק',
    btn_start           = 'התחל תדלוק',
    btn_refueling       = 'מתדלק...',
    info_owner          = 'בעלים',
    info_price          = 'מחיר / ל׳',
    liter               = 'ל׳',
    ecoDesc             = 'פחות כוח, יותר טווח נסיעה',
    normalDesc          = 'ביצועים וצריכה סטנדרטיים',
    superDesc           = 'עבור רכבים בעלי ביצועים גבוהים',
    elecDesc            = 'טעינה לרכבים חשמליים',
    confirm_title       = 'נדרש אישור',
    confirm_desc        = 'האם אתה בטוח שברצונך למכור? פעולה זו אינה ניתנת לביטול.',
    btn_confirm         = 'אשר',
    btn_cancel          = 'בטל',
    placeholder_amount  = 'סכום ($)',
    placeholder_liters  = 'כמות ליטרים',
    btn_withdraw        = 'משוך',
    btn_deposit         = 'הפקד',
    btn_buy             = 'קנה',
    btn_save_prices     = 'שמור מחירים',
    hint_safe           = 'יתרת הכספת משמשת אוטומטית לרכישת מלאי.',
    hint_stock          = 'מלאי נוכחי: {current} / {max} ל׳. התשלום יורד קודם מהכספת.',
    sell_warning        = 'אם תמכור את התחנה, תקבל 70% ממחיר המכירה פלוס יתרת הכספת. הפעולה סופית.',
    info_sell_value     = 'ערך מכירה: החזר של {percent}%',
    info_start_stock    = 'מלאי דלק התחלתי: {amount} ל׳',
    info_payments       = 'תשלומי לקוחות זורמים לכספת שלך',
}

function T(key)
    local lang = Config.Locales[Config.Locale] or Config.Locales['he']
    return lang[key] or key
end