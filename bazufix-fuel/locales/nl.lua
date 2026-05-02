if Config.Locale ~= 'nl' then return end

Config.Locales = Config.Locales or {}
Config.Locales['nl'] = {
    -- 3D Tekst (3D Metin)
    take_pump           = '[E] Pak de Pomp',
    return_pump         = '[G] Hang de Pomp Terug',
    open_menu           = '[E] Open Menu',
    remove_pump         = '[G] Verwijder de Pomp',
    attach_pump         = '[E] Sluit aan op Voertuig',
    buy_station_text    = '[E] Koop Station',
    manage_station_text = '[E] Beheer Station',

    -- Meldingen (Bildirimler)
    no_money            = 'Je hebt niet genoeg geld!',
    refuel_success      = 'Voertuig succesvol getankt.',
    station_bought      = 'Je hebt het station gekocht!',
    station_sold        = 'Je hebt het station verkocht.',
    already_owned       = 'Dit station heeft al een eigenaar.',
    not_owner           = 'Je bent niet de eigenaar van dit station.',
    price_updated       = 'Brandstofprijzen bijgewerkt.',
    low_fuel            = 'Waarschuwing: Brandstofniveau kritiek!',
    engine_stopped      = 'Motor gestopt - brandstof op!',
    stock_added         = 'Brandstofvoorraad toegevoegd aan station.',
    stock_low           = 'Waarschuwing: Brandstofvoorraad van het station is laag!',
    stock_empty         = 'Brandstofvoorraad van het station is op!',
    cash_withdrawn      = 'Geld opgenomen uit de stationskas.',
    cash_deposited      = 'Geld gestort in de stationskas.',

    -- Station UI (İstasyon UI)
    station_name        = 'Station Naam',
    station_owner       = 'Eigenaar',
    station_noowner     = 'Te Koop',
    station_buy         = 'Koop Station',
    station_sell        = 'Verkoop Station',
    station_manage      = 'Beheer Station',
    station_income      = 'Totale Inkomsten',
    station_setprice    = 'Prijzen Instellen',
    station_safe        = 'Stationskas',
    station_stock       = 'Brandstofvoorraad',
    station_buy_stock   = 'Voorraad Kopen',
    station_withdraw    = 'Geld Opnemen',
    station_deposit     = 'Geld Storten',
    station_safe_balance= 'Kassasaldo',
    station_stock_level = 'Voorraadniveau',
    liters              = 'liter',

    -- Aankoop Modal (Satın Alma Modalı)
    buy_modal_title     = 'Station Kopen',
    buy_modal_desc      = 'Wilt u dit station kopen?',
    buy_modal_price     = 'Station Prijs',
    buy_modal_confirm   = 'Kopen',
    buy_modal_cancel    = 'Annuleren',

    -- Brandstof UI (Yakıt UI)
    ui_title            = 'BRANDSTOFSOORTEN',
    ui_amount           = 'TANKHOEVEELHEID',
    ui_cost             = 'GESCHATTE KOSTEN',
    type_economic       = 'ECONOMISCH',
    type_normal         = 'NORMAAL',
    type_super          = 'SUPER',
    type_electric       = 'ELEKTRISCH',
    pay_cash            = 'CONTANT',
    pay_bank            = 'BANK',
    info_plate          = 'KENTEKEN',
    info_fuel           = 'BRANDSTOFNIVEAU',
    info_type           = 'BRANDSTOFSOORT',
    btn_start           = 'START MET TANKEN',
    btn_refueling       = 'AAN HET TANKEN...',
    info_owner          = 'EIGENAAR',
    info_price          = 'PRIJS / L',
    liter               = 'L',
    ecoDesc             = 'Minder vermogen, groter bereik',
    normalDesc          = 'Standaard prestaties & verbruik',
    superDesc           = 'Voor voertuigen met hoge prestaties',
    elecDesc            = 'Opladen voor elektrische voertuigen',
    confirm_title       = 'Bevestiging Vereist',
    confirm_desc        = 'Weet u zeker dat u wilt verkopen? Dit kan niet ongedaan worden gemaakt.',
    btn_confirm         = 'Bevestigen',
    btn_cancel          = 'Annuleren',
    placeholder_amount  = 'Bedrag ($)',
    placeholder_liters  = 'Aantal liters',
    btn_withdraw        = 'Opnemen',
    btn_deposit         = 'Storten',
    btn_buy             = 'Kopen',
    btn_save_prices     = 'Prijzen Opslaan',
    hint_safe           = 'Kassasaldo wordt automatisch gebruikt voor aankopen.',
    hint_stock          = 'Huidige voorraad: {current} / {max} L. Geld wordt eerst van de kas afgeschreven.',
    sell_warning        = 'Als u het station verkoopt, ontvangt u 70% van de koopprijs en het kassasaldo. Onomkeerbaar.',
    info_sell_value     = 'Verkoopwaarde: {percent}% terugbetaling',
    info_start_stock    = 'Beginvoorraad: {amount} L',
    info_payments       = 'Betalingen van klanten gaan naar uw kas',
}

function T(key)
    local lang = Config.Locales[Config.Locale] or Config.Locales['nl']
    return lang[key] or key
end