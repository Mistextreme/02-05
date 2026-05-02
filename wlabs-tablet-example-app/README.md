# WLabs Tablet Example App

This is an open-source custom app for WLabs Tablet. I made this as a template to make it easy for anyone to create custom apps, if you develop an app for my tablet please join my discord and show me! I would love to see custom apps made by the FiveM community.

Every file has comments to explain functions/features, feel free to open any file and explore/learn. The comments explain what each piece does, why it exists, and what you should change when turning this into your own app.

## What it shows

- Registering a custom tablet app from another resource.
- Loading an external NUI page inside the tablet.
- Calling a Lua `RegisterNUICallback` from the app UI.
- Clear examples of how to structure the ui to fit within the tablet.

## File structure

```text
wlabs-tablet-example-app/
  fxmanifest.lua        # FiveM manifest: resource metadata, files, ui_page, scripts
  client/main.lua       # Client Lua: registers the app and receives NUI callbacks
  html/nui.html         # Hidden FiveM ui_page, required but not shown to players
  html/tablet.html      # Visible app page loaded inside WLabs Tablet
  html/style.css        # App styling and responsive layout
  html/app.js           # Browser JS: form logic and Lua callback calls
  html/icons/hello.svg  # App store/home screen icon
```

## Install

1. Put this folder in your FiveM resources directory.
2. Make sure `wlabs-tablet` starts before this resource.
3. Add this to `server.cfg`:

```cfg
ensure wlabs-tablet
ensure wlabs-tablet-example-app
```

Open the tablet, download **Test App** from the app store and launch it.

## Start your own app

Use this resource as a copyable starting point:

1. Rename the folder to your app resource name.
2. Change `APP_KEY`, `label`, `description`, `gradient`, and icon paths in `client/main.lua`.
3. Replace the contents of `html/tablet.html` with your app UI.
4. Replace or extend the styles in `html/style.css`.
5. Add your browser logic in `html/app.js`.
6. Add Lua callbacks in `client/main.lua` for anything the browser needs from the game.
7. Add any new HTML, CSS, JS, image, font, or icon files to the `files` list in `fxmanifest.lua`.

## Important parts

`fxmanifest.lua` uses a hidden page for `ui_page`:

```lua
ui_page 'html/nui.html'
```

Do not set `ui_page` to the visible tablet app page. FiveM loads a resource's `ui_page` as that resource's own top-level NUI, so using `html/tablet.html` there makes the app appear full screen as soon as the resource starts. The visible app page should only be loaded by WLabs Tablet through the `ui` URL below.

`client/main.lua` registers the app:

```lua
exports['wlabs-tablet']:RegisterApp({
    key = 'wlabs_test',
    label = 'Test App',
    ui = 'https://cfx-nui-wlabs-tablet-example-app/html/tablet.html',
    icon = 'https://cfx-nui-wlabs-tablet-example-app/html/icons/hello.svg',
    resource = 'wlabs-tablet-example-app',
    fullscreen = true
})
```

Use this as a starting point to create whatever awesome app you want.

Thanks for checking out the tablet, join our discord to stay up to date with new scripts and updates! 

Discord: https://discord.gg/4dxDfWxKJf