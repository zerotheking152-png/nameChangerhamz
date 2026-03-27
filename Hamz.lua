-- hamzHub CUSTOM GUI + MINIMIZE (FIX 1000% - Fish It 2026)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "hamzHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "Main"
mainFrame.Size = UDim2.new(0, 420, 0, 400)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 255, 255)
stroke.Thickness = 4
stroke.Parent = mainFrame

-- TITLE BAR
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 1, 0)
title.BackgroundTransparency = 1
title.Text = "hamzHub"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = titleBar

-- MINIMIZE BUTTON
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 35, 0, 35)
minBtn.Position = UDim2.new(1, -75, 0, 8)
minBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
minBtn.Text = "–"
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.TextScaled = true
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = titleBar
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 8)

-- CLOSE BUTTON
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

-- CONTENT FRAME (yang bakal di-hide pas minimize)
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -50)
contentFrame.Position = UDim2.new(0, 0, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- DRAGGABLE (title bar + full frame)
local dragging, dragInput, dragStart, startPos
local function onDragStart(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end
local function onDragUpdate(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end

titleBar.InputBegan:Connect(onDragStart)
titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)
UserInputService.InputChanged:Connect(onDragUpdate)

-- MINIMIZE FUNCTION
local isMinimized = false
local originalSize = mainFrame.Size

minBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        contentFrame.Visible = false
        mainFrame.Size = UDim2.new(0, 420, 0, 50)  -- cuma title bar
        minBtn.Text = "+"
    else
        contentFrame.Visible = true
        mainFrame.Size = originalSize
        minBtn.Text = "–"
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- ==================== DEEP NAME CHANGER (PASTI WORK) ====================
local currentCustomName = ""

local function applyDeepName(char)
    if not char or currentCustomName == "" then return end
    
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.DisplayName = currentCustomName
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
    end
    
    local head = char:FindFirstChild("Head")
    if head then
        -- Override semua BillboardGui yang ada
        for _, gui in ipairs(head:GetChildren()) do
            if gui:IsA("BillboardGui") then
                for _, label in ipairs(gui:GetDescendants()) do
                    if label:IsA("TextLabel") and (label.Text == player.Name or label.Text == player.DisplayName or string.find(label.Text, player.Name)) then
                        label.Text = currentCustomName
                    end
                end
            end
        end
        
        -- Buat custom nametag kalau belum ada
        if not head:FindFirstChild("hamzNameTag") then
            local bill = Instance.new("BillboardGui")
            bill.Name = "hamzNameTag"
            bill.Adornee = head
            bill.AlwaysOnTop = true
            bill.Size = UDim2.new(0, 300, 0, 70)
            bill.StudsOffset = Vector3.new(0, 4.5, 0)
            bill.Parent = head
            
            local text = Instance.new("TextLabel")
            text.Size = UDim2.new(1, 0, 1, 0)
            text.BackgroundTransparency = 1
            text.Text = currentCustomName
            text.TextColor3 = Color3.fromRGB(0, 255, 255)
            text.TextScaled = true
            text.Font = Enum.Font.GothamBold
            text.TextStrokeTransparency = 0
            text.TextStrokeColor3 = Color3.new(0,0,0)
            text.Parent = bill
        end
    end
end

-- LOOP SUPER KUAT
task.spawn(function()
    while true do
        task.wait(0.2)
        if currentCustomName \~= "" and player.Character then
            applyDeepName(player.Character)
        end
    end
end)

player.CharacterAdded:Connect(function(char)
    task.wait(1.2)
    applyDeepName(char)
end)

-- ==================== NAMA UI ====================
local nameFrame = Instance.new("Frame")
nameFrame.Size = UDim2.new(1, -20, 0, 120)
nameFrame.Position = UDim2.new(0, 10, 0, 20)
nameFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
nameFrame.Parent = contentFrame
Instance.new("UICorner", nameFrame).CornerRadius = UDim.new(0, 10)

local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, 0, 0, 30)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = "🔹 NAMA CHANGER (DEEP)"
nameLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
nameLabel.TextScaled = true
nameLabel.Font = Enum.Font.GothamBold
nameLabel.Parent = nameFrame

local nameBox = Instance.new("TextBox")
nameBox.Size = UDim2.new(1, -20, 0, 45)
nameBox.Position = UDim2.new(0, 10, 0, 35)
nameBox.PlaceholderText = "Ketik nama custom lu..."
nameBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
nameBox.TextColor3 = Color3.new(1,1,1)
nameBox.TextScaled = true
nameBox.Parent = nameFrame
Instance.new("UICorner", nameBox).CornerRadius = UDim.new(0, 8)

local nameBtn = Instance.new("TextButton")
nameBtn.Size = UDim2.new(0.9, 0, 0, 40)
nameBtn.Position = UDim2.new(0.05, 0, 0, 85)
nameBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
nameBtn.Text = "🚀 GANTI NAMA"
nameBtn.TextColor3 = Color3.new(1,1,1)
nameBtn.TextScaled = true
nameBtn.Font = Enum.Font.GothamBold
nameBtn.Parent = nameFrame
Instance.new("UICorner", nameBtn).CornerRadius = UDim.new(0, 8)

nameBtn.MouseButton1Click:Connect(function()
    local newName = nameBox.Text
    if newName == "" then return end
    currentCustomName = newName
    if player.Character then applyDeepName(player.Character) end
    print("✅ hamzHub: Nama diganti jadi " .. newName)
end)

-- ==================== LEVEL UI ====================
local levelFrame = Instance.new("Frame")
levelFrame.Size = UDim2.new(1, -20, 0, 120)
levelFrame.Position = UDim2.new(0, 10, 0, 160)
levelFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
levelFrame.Parent = contentFrame
Instance.new("UICorner", levelFrame).CornerRadius = UDim.new(0, 10)

local levelLabel = Instance.new("TextLabel")
levelLabel.Size = UDim2.new(1, 0, 0, 30)
levelLabel.BackgroundTransparency = 1
levelLabel.Text = "🔹 LEVEL CHANGER"
levelLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
levelLabel.TextScaled = true
levelLabel.Font = Enum.Font.GothamBold
levelLabel.Parent = levelFrame

local levelBox = Instance.new("TextBox")
levelBox.Size = UDim2.new(1, -20, 0, 45)
levelBox.Position = UDim2.new(0, 10, 0, 35)
levelBox.PlaceholderText = "Masukin level baru..."
levelBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
levelBox.TextColor3 = Color3.new(1,1,1)
levelBox.TextScaled = true
levelBox.Parent = levelFrame
Instance.new("UICorner", levelBox).CornerRadius = UDim.new(0, 8)

local levelBtn = Instance.new("TextButton")
levelBtn.Size = UDim2.new(0.9, 0, 0, 40)
levelBtn.Position = UDim2.new(0.05, 0, 0, 85)
levelBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
levelBtn.Text = "🚀 GANTI LEVEL"
levelBtn.TextColor3 = Color3.new(1,1,1)
levelBtn.TextScaled = true
levelBtn.Font = Enum.Font.GothamBold
levelBtn.Parent = levelFrame
Instance.new("UICorner", levelBtn).CornerRadius = UDim.new(0, 8)

levelBtn.MouseButton1Click:Connect(function()
    local newLevel = tonumber(levelBox.Text)
    if newLevel then
        local leaderstats = player:WaitForChild("leaderstats", 5)
        if leaderstats then
            local lvl = leaderstats:FindFirstChild("Level") or leaderstats:FindFirstChildWhichIsA("IntValue")
            if lvl then lvl.Value = newLevel end
        end
    end
end)

print("✅ hamzHub CUSTOM GUI + MINIMIZE LOADED! Klik – buat minimize, drag kemana aja!")
