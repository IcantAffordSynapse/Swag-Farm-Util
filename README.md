# Swag Farm Util

<p align="center">
  <img src="assets/New%20Project%20-%202026-07-15T213942.974.png" alt="Swag Farm Util Logo" width="250">
</p>

<p align="center">
  AI did the readme.md and idk what to put here.
</p>

<p align="center">
  <a href="https://discord.gg/vaehz">Discord Support</a>
</p>

---

## 🚀 Loadstring

```lua
getgenv().SwagSettings = {
    -- Performance
    FpsCap = 0, -- 0 = No limit
    ClearTerrain = true,
    MinimizeQualityLevels = true,
    MinimizeLighting = true,
    RemoveOtherPlayers = true,
    RemoveVFX = true,
    DisableCoreGui = true,
    OverrideMaterials = true,
    Disable3dRendering = true,
    ---- ^ 3D Rendering
        OnlyDisableUnfocused = false, -- Disable3dRendering must be enabled in order to work.

    -- Serverhop
    Serverhop = false,
    ServerhopDelay = 3600, -- Seconds
    AllowSameServer = true,
    AutoExecute = true,

    -- Extra
    CheckVersion = true,
    RejoinOnKick = true,
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/IcantAffordSynapse/Swag-Farm-Util/refs/heads/main/src/source.lua"))()
```

---

### ⚙️ Configuration

| Setting | Type | Description |
| --- | --- | --- |
| `FpsCap` | Number | Sets the FPS limit. `0` makes it infinite. |
| `ClearTerrain` | Boolean | Removes terrain. |
| `MinimizeQualityLevels` | Boolean | Sets Roblox quality settings to the minimum. |
| `MinimizeLighting` | Boolean | Reduces lighting effects. |
| `RemoveOtherPlayers` | Boolean | Destroys all other player's characters. |
| `RemoveVFX` | Boolean | Destroys all VFX within the workspace. |
| `DisableCoreGui` | Boolean | Disables Roblox CoreGui elements. |
| `OverrideMaterials` | Boolean | Sets all materials to Smooth Plastic. |
| `Disable3dRendering` | Boolean | Disables 3D rendering. |
| `OnlyDisableUnfocused` | Boolean | Only disables 3D rendering when the window is unfocused. Requires `Disable3dRendering`. |
| `Serverhop` | Boolean | Enables automatic server hopping. |
| `ServerhopDelay` | Number | Delay between server hops in seconds. |
| `AllowSameServer` | Boolean | Allows joining the same server again when server hopping. |
| `AutoExecute` | Boolean | Automatically re-executes when switching servers. |
| `CheckVersion` | Boolean | Checks for new script versions on launch + Auto updates the script. |
| `RejoinOnKick` | Boolean | Automatically rejoins after being disconnected from the game. |

---

## 💬 Support

Need help, found a bug, or have a suggestion?

Join the support Discord:

https://discord.gg/vaehz
