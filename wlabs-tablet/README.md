# wlabs-tablet

Premium tablet for **Qbox** or **qb-core**.

## Installation

1. Place `wlabs-tablet` in your resources folder.
2. Import `sql/wlabs_tablet.sql`.
3. **Only if `Config.UseItem = true`:** add a usable item matching **`Config.ItemName`** to your inventory (see snippets below).
4. Below are dependencies; start `wlabs-tablet` **after** these:
  - **qbx_core** (Qbox) *or* **qb-core** (QB)
  - ox_lib
  - oxmysql
5. Start `wlabs-tablet`.
6. **Camera uploads** (if you use the camera app): set `Config.Camera.Upload.method` in `config.lua` and add the matching API convar to `server.cfg`.

## Item definition (when `Config.UseItem` is `true`)

Use the same **`Config.ItemName`** everywhere (default in `config.lua` is `tablet`; the examples use `wlabs_tablet` — pick one name and keep config + items in sync).

### ox_inventory (`data/items.lua` or your items file)

```lua
['wlabs_tablet'] = {
    label = 'WLabs Tablet',
    weight = 900,
    stack = false,
    close = true,
}
```

### qb-inventory / typical QB item (`qb-core/shared/items.lua` or your items file; paths vary by fork)

```lua
['wlabs_tablet'] = {
    name = 'wlabs_tablet',
    label = 'WLabs Tablet',
    weight = 900,
    type = 'item',
    image = 'wlabs_tablet.png',
    unique = true,
    useable = true,
    shouldClose = true,
    combinable = nil,
    description = 'A tablet device'
},
```

### `Config.Camera.Upload.method`

Choose one:
| `fivemanage` | Uploads to **Fivemanage** |
| `fivemerr` | Uploads to **Fivemerr** |

### API keys (server.cfg)

Keys are **not** set in `config.lua`. Add **one** of these lines to `server.cfg`, matching your `Upload.method`:

```cfg
set wlabs_tablet_upload_fivemanage_key "YOUR_FIVEMANAGE_API_TOKEN"
```

```cfg
set wlabs_tablet_upload_fivemerr_key "YOUR_FIVEMERR_API_KEY"
```

Get tokens from your Fivemanage / Fivemerr dashboard. If the key is missing while using `fivemanage` or `fivemerr`, camera saves to the cloud will fail.

## Thank you for trying my tablet

Join our Discord [https://discord.gg/YHvctYzENV](https://discord.gg/YHvctYzENV)