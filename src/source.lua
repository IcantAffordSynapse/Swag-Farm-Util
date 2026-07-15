local rendering = settings().Rendering
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")


if not isfolder("SwagFarmingUtil") then
    makefolder("SwagFarmingUtil")
end
if not isfile("SwagFarmingUtil/Version.txt") then
    writefile("SwagFarmingUtil/Version.txt", game:HttpGet("https://raw.githubusercontent.com/IcantAffordSynapse/Swag-Farm-Util/refs/heads/main/src/version.txt"))
end
if not isfile("SwagFarmingUtil/Source.lua") then
    writefile("SwagFarmingUtil/Source.lua", game:HttpGet("https://raw.githubusercontent.com/IcantAffordSynapse/Swag-Farm-Util/refs/heads/main/src/source.lua"))
end

if not game.IsLoaded then game.IsLoaded:Wait() end

if getgenv().SwagSettings then
    writefile("SwagFarmingUtil/Config.json", HttpService:JSONEncode(getgenv().SwagSettings))
else
    getgenv().SwagSettings = HttpService:JSONDecode(readfile("SwagFarmingUtil/Config.json"))
end

if getgenv().SwagSettings.CheckVersion then
    local latest = game:HttpGet("https://raw.githubusercontent.com/IcantAffordSynapse/Swag-Farm-Util/refs/heads/main/src/version.txt")
    local current = readfile("SwagFarmingUtil/Version.txt")

    if latest ~= current then
        writefile("SwagFarmingUtil/Source.lua", game:HttpGet("https://raw.githubusercontent.com/IcantAffordSynapse/Swag-Farm-Util/refs/heads/main/src/source.lua"))
        writefile("SwagFarmingUtil/Version.txt", game:HttpGet("https://raw.githubusercontent.com/IcantAffordSynapse/Swag-Farm-Util/refs/heads/main/src/version.txt"))
        loadstring(readfile("SwagFarmingUtil/Source.lua"))()
        return
    end
end

---
-- Unfocused Screen
---
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
ScreenGui.DisplayOrder = 2147483647
ScreenGui.Parent = gethui()
ScreenGui.Enabled = false

local Frame = Instance.new("Frame")
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.Size = UDim2.new(1, 0, 1, 0)
Frame.BorderSizePixel = 0
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.Parent = ScreenGui

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.Image = "rbxassetid://80314169719107"
ImageLabel.BackgroundTransparency = 1
ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel.Size = UDim2.new(0.25940337777137756, 0, 0.4993757903575897, 0)
ImageLabel.BorderSizePixel = 0
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.Parent = Frame

local AspectRatio = Instance.new("UIAspectRatioConstraint")
AspectRatio.Name = "AspectRatio"
AspectRatio.Parent = ImageLabel

---
-- Functionz
---
local function hookChar(plr)
    if plr.Character then
        plr.Character:Destroy()
    end

    plr.CharacterAdded:Connect(function(c)
        c:Destroy()
    end)
end

local function getServer()
    local cursor = ""
    local chosen, count = nil, 0

    while true do
        local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100%s")
            :format(game.PlaceId, cursor ~= "" and ("&cursor=" .. cursor) or "")

        local ok, res = pcall(function()
            return game:HttpGet(url)
        end)
        if not ok then break end

        local ok2, data = pcall(function()
            return HttpService:JSONDecode(res)
        end)
        if not ok2 then break end

        for _, server in ipairs(data.data) do
            print("SERVER")
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                count += 1
                if math.random(1, count) == 1 then
                    chosen = server.id
                end
            end
        end

        if chosen then break end

        if data.nextPageCursor and data.nextPageCursor ~= "" then
            cursor = data.nextPageCursor
        else
            break
        end
    end

    return chosen
end

---
-- Performance
---
if getgenv().SwagSettings.MinimizeQualityLevels then
    rendering.QualityLevel = Enum.QualityLevel.Level01
    rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level00
end

if getgenv().SwagSettings.Disable3dRendering then
    if not getgenv().SwagSettings.OnlyDisableUnfocused then
        RunService:Set3dRenderingEnabled(false)
        ScreenGui.Enabled = true
    else
        UserInputService.WindowFocused:Connect(function()
            RunService:Set3dRenderingEnabled(true)
            ScreenGui.Enabled = false
        end)

        UserInputService.WindowFocusReleased:Connect(function()
            RunService:Set3dRenderingEnabled(false)
            ScreenGui.Enabled = true
        end)
    end
end

if getgenv().SwagSettings.ClearTerrain then
    workspace.Terrain:Clear()
end

if getgenv().SwagSettings.DisableCoreGui then
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
end

if getgenv().SwagSettings.MinimizeLighting then
    Lighting.GlobalShadows = false
    Lighting.Technology = Enum.Technology.Compatibility
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect")
        or v:IsA("Atmosphere")
        or v:IsA("Sky")
        or v:IsA("Clouds") then
            v:Destroy()
        end
    end
end

if getgenv().SwagSettings.RemoveOtherPlayers then
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer then
            hookChar(plr)
        end
    end

    Players.PlayerAdded:Connect(function(plr)
        if plr ~= Players.LocalPlayer then
            hookChar(plr)
        end
    end)
end

for _, v in ipairs(workspace:GetDescendants()) do
    if getgenv().SwagSettings.RemoveVFX then
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam")
        or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Highlight")
        or v:IsA("Sparkles") or v:IsA("Explosion") then
            v:Destroy()
            continue
        end
    end

    if getgenv().SwagSettings.MinimizeQualityLevels then
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            continue
        end
    end
end

setfpscap(getgenv().SwagSettings.FpsCap)

---
-- Serverhopping
---
if getgenv().SwagSettings.Serverhop then
    task.spawn(function()
        task.wait(getgenv().SwagSettings.ServerhopDelay)
        local targetJobId = getgenv().SwagSettings.AllowSameServer and game.JobId or getServer()

        if not targetJobId then
            game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer)
        else
            game:GetService("TeleportService"):TeleportToPlaceInstance(
                game.PlaceId,
                targetJobId,
                Players.LocalPlayer
            )
        end
    end)
end

GuiService.ErrorMessageChanged:Connect(function()
    if getgenv().SwagSettings.RejoinOnKick then
        TeleportService:Teleport(game.PlaceId)
    end
end)

---
-- AutoExec
---
if getgenv().SwagSettings.AutoExecute then
    queue_on_teleport(readfile("SwagFarmingUtil/Source.lua"))
end
