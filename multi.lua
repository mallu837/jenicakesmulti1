local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local RawAssetId = "134040538441909"

local function GetAssetImage(id)
    local cleanId = tostring(id):gsub("%D", "")
    local success, result = pcall(function()
        local obj = game:GetObjects("rbxassetid://" .. cleanId)
        if obj and #obj > 0 and obj[1]:IsA("Decal") then
            return obj[1].Texture
        end
    end)
    if success and result and result ~= "" then
        return result
    end
    return "rbxthumb://type=Asset&id=" .. cleanId .. "&w=420&h=420"
end

local LogoId = GetAssetImage(RawAssetId)

-- 修复 1: 安全获取 targetParent，防止 Delta 不支持 gethui 导致报错
local targetParent = PlayerGui
if gethui then
    local ok, res = pcall(gethui)
    if ok and res then
        targetParent = res
    end
end

if targetParent:FindFirstChild("JenAntiHitGui") then
    targetParent.JenAntiHitGui:Destroy()
end

local Theme = {
    Background    = Color3.fromRGB(20, 12, 28),
    Card          = Color3.fromRGB(36, 22, 48),
    Border        = Color3.fromRGB(236, 72, 153),
    AccentPurple  = Color3.fromRGB(168, 85, 247),
    AccentPink    = Color3.fromRGB(244, 114, 182),
    TextTitle     = Color3.fromRGB(255, 192, 230),
    TextNormal    = Color3.fromRGB(255, 255, 255),
    TextMuted     = Color3.fromRGB(190, 160, 205),
    CloseBtn      = Color3.fromRGB(225, 29, 72),
    MinBtn        = Color3.fromRGB(55, 35, 75),
    Green         = Color3.fromRGB(34, 197, 94),
    Red           = Color3.fromRGB(239, 68, 68),
    Discord       = Color3.fromRGB(88, 101, 242),
}

local Scripts = {
    { name="Jenicakes Anti Hit", tag="KEYLESS", pinned=true,
      url="https://raw.githubusercontent.com/mallu837/jenicakeshub/refs/heads/main/steal%20an%20egg/loader" },
    { name="Zeroin Hub",         tag="KEYLESS",
      url="https://zeroinhub.com/api/script" },
    { name="DE:CODE",            tag="KEYLESS",
      url="https://raw.githubusercontent.com/ItzYumi/Decode/refs/heads/main/DE%3ACODE.lua" },
    { name="Foxname",            tag="KEYLESS",
      url="https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/Fn-stealanegg.lua" },
    { name="Sena V7",           tag="KEYLESS",
      url="https://senahub.xyz/senaloader" },
    { name="LKZ Hub",            tag="KEYLESS",
      url="https://raw.githubusercontent.com/LucasggkX/LKZ-Hub/refs/heads/main/Loader.lua" },
    { name="BLYXO Hub",          tag="KEYLESS",
      url="https://flowauth.net/v1/loaders/69d3463240384f3a73fbe32c178093a2.lua" },
    { name="Chilli Hub",         tag="KEYLESS",
      url="https://raw.githubusercontent.com/tienkhanh1/Chilli-Hub-Script/refs/heads/main/StealAnEgg" },
    { name="Venyx Hub",          tag="KEYLESS",
      url="https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub" },
    { name="PulseZax",           tag="KEYLESS",
      url="https://raw.githubusercontent.com/PulseZax/Loader/refs/heads/main/.lua" },
    { name="Clover Hub",         tag="KEY",
      url="https://cloverhub.app/clover.lua" },
    { name="BF Loader",          tag="KEY",
      url="https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua" },
    { name="Fyy Community",      tag="KEY",
      url="https://FyyCommunity.my.id" },
    { name="Speed Hub X",        tag="KEY",
      url="https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua" },
    { name="Ajjan",              tag="KEY",
      url="https://api.luarmor.net/files/v4/loaders/359e97f8618e9008afe5f496184ebb7c.lua" },
    { name="Chiyo Hub",          tag="KEY",
      url="https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua" },
    { name="Solix Hub",          tag="KEY",
      url="https://raw.githubusercontent.com/bao8jl/solixhub/main/loader" },
    { name="OMG Hub",            tag="KEY",
      url="https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua" },
    { name="Nasi Rendang",       tag="KEY",
      url="https://raw.githubusercontent.com/JualNasiRendang/loader/refs/heads/main/main.lua" },
    { name="Night Hub",          tag="KEY",
      url="https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/StealEggOnly.luau" },
    { name="VoidShell Hub",      tag="PATCHED",
      url="https://raw.githubusercontent.com/VoidShell-null/VoidShell-Hub/refs/heads/main/Scripts/StealAnEgg.luau" },
}

local function GetTagColor(entry)
    if entry.tag == "PATCHED" then
        return Theme.Red
    else
        return Theme.Green
    end
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JenAntiHitGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screenGui.DisplayOrder = 1000
screenGui.Parent = targetParent

local openToggleBtn = Instance.new("TextButton")
openToggleBtn.Name = "OpenToggleBtn"
openToggleBtn.Size = UDim2.new(0, 38, 0, 38)
openToggleBtn.Position = UDim2.new(0.04, 0, 0.45, 0)
openToggleBtn.BackgroundColor3 = Theme.Background
openToggleBtn.BackgroundTransparency = 0.2
openToggleBtn.Text = ""
openToggleBtn.Active = true
openToggleBtn.Draggable = true
openToggleBtn.Visible = false
openToggleBtn.ZIndex = 2000
openToggleBtn.Parent = screenGui

do
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = openToggleBtn

    local s = Instance.new("UIStroke")
    s.Color = Theme.Border
    s.Thickness = 2
    s.Parent = openToggleBtn

    local logo = Instance.new("ImageLabel")
    logo.Size = UDim2.new(0, 22, 0, 22)
    logo.Position = UDim2.new(0.5, -11, 0.5, -11)
    logo.BackgroundTransparency = 1
    logo.Image = LogoId
    logo.ScaleType = Enum.ScaleType.Fit
    logo.ZIndex = 2001
    logo.Parent = openToggleBtn
end

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 230, 0, 378)
mainFrame.Position = UDim2.new(0.5, -115, 0.5, -189)
mainFrame.BackgroundColor3 = Theme.Background
mainFrame.BackgroundTransparency = 0.4
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

do
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = mainFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Border
    stroke.Thickness = 1.6
    stroke.Parent = mainFrame

    local bgImage = Instance.new("ImageLabel")
    bgImage.Name = "BackgroundImage"
    bgImage.Size = UDim2.fromScale(1, 1)
    bgImage.BackgroundTransparency = 1
    bgImage.Image = LogoId
    bgImage.ScaleType = Enum.ScaleType.Crop
    bgImage.ImageTransparency = 0.55
    bgImage.Parent = mainFrame

    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 10)
    bgCorner.Parent = bgImage

    local titleLogo = Instance.new("ImageLabel")
    titleLogo.Size = UDim2.fromOffset(22, 22)
    titleLogo.Position = UDim2.new(0, 8, 0, 6)
    titleLogo.BackgroundTransparency = 1
    titleLogo.Image = LogoId
    titleLogo.ScaleType = Enum.ScaleType.Fit
    titleLogo.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -90, 0, 30)
    titleLabel.Position = UDim2.new(0, 36, 0, 2)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "JENICAKES MULTI"
    titleLabel.TextColor3 = Theme.TextTitle
    titleLabel.TextSize = 13
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = mainFrame
end

local function HideGui()
    mainFrame.Visible = false
    openToggleBtn.Visible = true
end

local function ShowGui()
    openToggleBtn.Visible = false
    mainFrame.Visible = true
end

openToggleBtn.MouseButton1Click:Connect(ShowGui)

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 20, 0, 20)
minBtn.Position = UDim2.new(1, -48, 0, 6)
minBtn.BackgroundColor3 = Theme.MinBtn
minBtn.Text = "-"
minBtn.TextColor3 = Theme.TextNormal
minBtn.TextSize = 13
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = mainFrame

do
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 5)
    c.Parent = minBtn
    local s = Instance.new("UIStroke")
    s.Color = Theme.AccentPurple
    s.Thickness = 1
    s.Transparency = 0.5
    s.Parent = minBtn
end

minBtn.MouseButton1Click:Connect(HideGui)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -24, 0, 6)
closeBtn.BackgroundColor3 = Theme.CloseBtn
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 10
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

do
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 5)
    c.Parent = closeBtn
end

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local tabKeylessBtn = Instance.new("TextButton")
tabKeylessBtn.Size = UDim2.new(0.5, -10, 0, 20)
tabKeylessBtn.Position = UDim2.new(0, 6, 0, 34)
tabKeylessBtn.BackgroundColor3 = Theme.Green
tabKeylessBtn.Text = "KEYLESS"
tabKeylessBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tabKeylessBtn.TextSize = 10
tabKeylessBtn.Font = Enum.Font.GothamBold
tabKeylessBtn.Parent = mainFrame

do
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 5)
    c.Parent = tabKeylessBtn
end

local tabKeyBtn = Instance.new("TextButton")
tabKeyBtn.Size = UDim2.new(0.5, -10, 0, 20)
tabKeyBtn.Position = UDim2.new(0.5, 4, 0, 34)
tabKeyBtn.BackgroundColor3 = Theme.Card
tabKeyBtn.Text = "KEY"
tabKeyBtn.TextColor3 = Theme.TextMuted
tabKeyBtn.TextSize = 10
tabKeyBtn.Font = Enum.Font.GothamSemibold
tabKeyBtn.Parent = mainFrame

do
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 5)
    c.Parent = tabKeyBtn
end

local keylessContainer = Instance.new("Frame")
keylessContainer.Size = UDim2.new(1, 0, 1, -78)
keylessContainer.Position = UDim2.new(0, 0, 0, 58)
keylessContainer.BackgroundTransparency = 1
keylessContainer.Visible = true
keylessContainer.Parent = mainFrame

local keyContainer = Instance.new("Frame")
keyContainer.Size = UDim2.new(1, 0, 1, -78)
keyContainer.Position = UDim2.new(0, 0, 0, 58)
keyContainer.BackgroundTransparency = 1
keyContainer.Visible = false
keyContainer.Parent = mainFrame

local discordLabel = Instance.new("TextButton")
discordLabel.Size = UDim2.new(1, -12, 0, 16)
discordLabel.Position = UDim2.new(0, 6, 1, -20)
discordLabel.BackgroundTransparency = 1
discordLabel.Text = "discord.gg/GFZYsspybS"
discordLabel.TextColor3 = Theme.Discord
discordLabel.TextSize = 9
discordLabel.Font = Enum.Font.Gotham
discordLabel.TextXAlignment = Enum.TextXAlignment.Center
discordLabel.TextTruncate = Enum.TextTruncate.AtEnd
discordLabel.AutoButtonColor = false
discordLabel.Parent = mainFrame

-- 修复 2: 安全调用剪贴板，防止报错
discordLabel.MouseButton1Click:Connect(function()
    if setclipboard then
        pcall(setclipboard, "https://discord.gg/GFZYsspybS")
    else
        warn("你的执行器不支持自动复制剪贴板")
    end
end)

tabKeylessBtn.MouseButton1Click:Connect(function()
    keylessContainer.Visible = true
    keyContainer.Visible = false
    tabKeylessBtn.BackgroundColor3 = Theme.Green
    tabKeylessBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabKeylessBtn.Font = Enum.Font.GothamBold
    tabKeyBtn.BackgroundColor3 = Theme.Card
    tabKeyBtn.TextColor3 = Theme.TextMuted
    tabKeyBtn.Font = Enum.Font.GothamSemibold
end)

tabKeyBtn.MouseButton1Click:Connect(function()
    keylessContainer.Visible = false
    keyContainer.Visible = true
    tabKeyBtn.BackgroundColor3 = Theme.Green
    tabKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabKeyBtn.Font = Enum.Font.GothamBold
    tabKeylessBtn.BackgroundColor3 = Theme.Card
    tabKeylessBtn.TextColor3 = Theme.TextMuted
    tabKeylessBtn.Font = Enum.Font.GothamSemibold
end)

local function BuildList(container, entries)
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -6, 1, -4)
    scrollFrame.Position = UDim2.new(0, 3, 0, 2)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 3
    scrollFrame.ScrollBarImageColor3 = Theme.AccentPurple
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.Parent = container

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 4)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = scrollFrame

    local listPadding = Instance.new("UIPadding")
    listPadding.PaddingTop = UDim.new(0, 3)
    listPadding.PaddingLeft = UDim.new(0, 3)
    listPadding.PaddingRight = UDim.new(0, 3)
    listPadding.Parent = scrollFrame

    for i, entry in ipairs(entries) do
        local tagColor = GetTagColor(entry)

        local row = Instance.new("TextButton")
        row.Name = "Row_" .. i
        row.Size = UDim2.new(1, 0, 0, 32)
        row.BackgroundColor3 = Theme.Card
        row.BackgroundTransparency = 0.3
        row.Text = ""
        row.LayoutOrder = i
        row.AutoButtonColor = false
        row.Parent = scrollFrame

        do
            local rc = Instance.new("UICorner")
            rc.CornerRadius = UDim.new(0, 6)
            rc.Parent = row

            local rs = Instance.new("UIStroke")
            rs.Color = tagColor
            rs.Thickness = 1
            rs.Transparency = 0.45
            rs.Parent = row
        end

        local tagBadge = Instance.new("Frame")
        tagBadge.Size = UDim2.new(0, 52, 0, 17)
        tagBadge.Position = UDim2.new(0, 5, 0.5, -8)
        tagBadge.BackgroundColor3 = tagColor
        tagBadge.BackgroundTransparency = 0.2
        tagBadge.Parent = row

        do
            local bc = Instance.new("UICorner")
            bc.CornerRadius = UDim.new(0, 4)
            bc.Parent = tagBadge

            local tagLabel = Instance.new("TextLabel")
            tagLabel.Size = UDim2.fromScale(1, 1)
            tagLabel.BackgroundTransparency = 1
            tagLabel.Text = entry.tag
            tagLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            tagLabel.TextSize = 8
            tagLabel.Font = Enum.Font.GothamBold
            tagLabel.Parent = tagBadge
        end

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, -100, 1, 0)
        nameLabel.Position = UDim2.new(0, 62, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = entry.name
        nameLabel.TextColor3 = entry.pinned and Theme.TextTitle or Theme.TextNormal
        nameLabel.TextSize = 10
        nameLabel.Font = entry.pinned and Enum.Font.GothamBold or Enum.Font.Gotham
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
        nameLabel.Parent = row

        local execBtn = Instance.new("TextButton")
        execBtn.Size = UDim2.new(0, 28, 0, 19)
        execBtn.Position = UDim2.new(1, -33, 0.5, -9)
        execBtn.BackgroundColor3 = tagColor
        execBtn.BackgroundTransparency = 0.2
        execBtn.Text = "▶"
        execBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        execBtn.TextSize = 10
        execBtn.Font = Enum.Font.GothamBold
        execBtn.Parent = row

        do
            local ec = Instance.new("UICorner")
            ec.CornerRadius = UDim.new(0, 4)
            ec.Parent = execBtn
        end

        row.MouseEnter:Connect(function() row.BackgroundTransparency = 0.1 end)
        row.MouseLeave:Connect(function() row.BackgroundTransparency = 0.3 end)

        -- 修复 3: 安全执行外部脚本，防止 loadstring 报错导致整体崩溃
        local function runScript()
            local savedGui = screenGui
            local ok, err = pcall(function()
                local fetchedCode = game:HttpGet(entry.url, true)
                if fetchedCode then
                    local func, loadErr = loadstring(fetchedCode)
                    if func then
                        func()
                    else
                        warn("[JenHub] Loadstring error: " .. tostring(loadErr))
                    end
                else
                    warn("[JenHub] Failed to fetch code from " .. entry.name)
                end
            end)
            if savedGui and not savedGui.Parent then
                savedGui.Parent = targetParent
            end
            if not ok then
                warn("[JenHub] Failed to load " .. entry.name .. ": " .. tostring(err))
            end
        end

        execBtn.MouseButton1Click:Connect(runScript)
        row.MouseButton1Click:Connect(runScript)
    end
end

local keylessEntries, keyEntries = {}, {}
for _, entry in ipairs(Scripts) do
    if entry.tag == "KEYLESS" then
        table.insert(keylessEntries, entry)
    else
        table.insert(keyEntries, entry)
    end
end

BuildList(keylessContainer, keylessEntries)
BuildList(keyContainer, keyEntries)

return {
    ScreenGui  = screenGui,
    MainFrame  = mainFrame,
    Theme      = Theme,
    LogoId     = LogoId,
}
