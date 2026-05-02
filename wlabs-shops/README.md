## wlabs-shops

Cart-based shop UI for QBCore/Qbox using `ox_inventory`, `ox_target` and `ox_lib`.
Join our Discord! https://discord.gg/fSeqDaprxs
Make sure to remove all the shops from your ox_inventory/data/shops.lua!

### Features

- **Modern cart UI**: Click to move items from the shop list into a cart, with live total.
- **Cash / bank checkout**: Players choose to pay with cash or bank, with optional `tgg-banking` transaction log when paying by bank.
- **Ped targets & blips**: Every shop defines one or more ped locations that get `ox_target` entries and optional map blips.
- **Multiple shop types**: General stores, liquor, hardware, ammunition already set up, add as many shops as you want.
- **Inventory-aware**: Uses `ox_inventory` item definitions for labels/images and lets you choose between dropping overflow items on the ground or hard-denying the purchase when the player’s pockets are full.
- **Job access control**: Restrict shops to specific jobs and minimum grades using `groups`.
- **Grade-restricted items**: Lock individual inventory items to a minimum job grade using `grade`.
- **Configurable UI colors**: Change the shop UI accent color globally or per-shop via `config.lua`.

### Dependencies

- `ox_lib`
- `ox_inventory`
- `ox_target`
- `qbx_core`
- Optional: `tgg-banking` (for detailed bank transaction logging when paying with bank)

Make sure these dependencies are started before `wlabs-shops`.

### Configuration (`config.lua`)

#### Global UI / overflow config

At the top of `config.lua` you have global UI configuration:

```lua
Config = Config or {}

Config.UI = Config.UI or {
    accent = '#721635',
}
```

You can change the accent to whatever matches your framework/server branding, for example:

```lua
Config.UI = Config.UI or {
    accent = '#22c55e', -- emerald green
}
```

If you want to **deny purchases** when the player cannot carry everything (no drop, no charge), set:

```lua
Config.overflowdrop = false
```

If true items that do not fit in the players inventory will be dropped on the ground.

#### Shop structure

Every shop in `Config.Shops` has this basic structure:

- **`name`**: Internal shop name (string).
- **`label`**: Display name shown in the UI and blips.
- **`blip`** (optional):
  - `id`: Blip sprite ID.
  - `colour`: Blip color.
  - `scale`: Blip size.
- **`ui`** (optional):
  - `accent`: Hex accent color (string).
  - `accentLight` / `accentDark`: Hex overrides for lighter/darker shades (optional; auto-derived if omitted).
- **`groups`** (optional): Lock entire shops to a job grade, or lock individual items to job grade.
- **`inventory`**: Array of items sold by the shop:

  ```lua
  inventory = {
      { name = 'sandwich', price = 10 },
      { name = 'water_bottle', price = 10 },
  },
  ```

  - `name` must match an `ox_inventory` item name.
  - `price` is the per-unit price (number).
  - `grade` on an item requires the player's job grade to be equal to or greater than the grade value.

#### Job-lock examples

Use `groups` to require a job and minimum grade for shop access:

```lua
groups = { police = 0 }
```

Use `grade` on inventory rows to restrict a specific item:

```lua
{ name = 'smg_ammo', price = 5, grade = 4 }, -- grade 4+ only
```
