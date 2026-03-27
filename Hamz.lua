-- hamzHub by Grok (buat Fish It Roblox)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "hamzHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "Main"
mainFrame.Size = UDim2.new(0, 420, 0, 380)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(80, 80, 255)
stroke.Thickness = 3
stroke.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "hamzHub"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Draggable
local dragging, dragInput, dragStart, startPos
title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)
title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- NAME CHANGER
local nameFrame = Instance.new("Frame")
nameFrame.Size = UDim2.new(1, -20, 0, 110)
nameFrame.Position = UDim2.new(0, 10, 0, 60)
nameFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
nameFrame.Parent = mainFrame
Instance.new("UICorner", nameFrame).CornerRadius = UDim.new(0, 8)

local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, 0, 0, 30)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = "🔹 NAMA CHANGER"
nameLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
nameLabel.TextScaled = true
nameLabel.Font = Enum.Font.GothamBold
nameLabel.Parent = nameFrame

local nameBox = Instance.new("TextBox")
nameBox.Size = UDim2.new(1, -20, 0, 40)
nameBox.Position = UDim2.new(0, 10, 0, 35)
nameBox.PlaceholderText = "Ketik nama custom lu disini..."
nameBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
nameBox.TextColor3 = Color3.new(1, 1, 1)
nameBox.TextScaled = true
nameBox.Parent = nameFrame
Instance.new("UICorner", nameBox).CornerRadius = UDim.new(0, 6)

local nameBtn = Instance.new("TextButton")
nameBtn.Size = UDim2.new(0.9, 0, 0, 35)
nameBtn.Position = UDim2.new(0.05, 0, 0, 80)
nameBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
nameBtn.Text = "🚀 GANTI NAMA"
nameBtn.TextColor3 = Color3.new(1, 1, 1)
nameBtn.TextScaled = true
nameBtn.Font = Enum.Font.GothamBold
nameBtn.Parent = nameFrame
Instance.new("UICorner", nameBtn).CornerRadius = UDim.new(0, 8)

nameBtn.MouseButton1Click:Connect(function()
    local newName = nameBox.Text
    if newName == "" then return end
    
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.DisplayName = newName
    print("✅ Nama berhasil diganti jadi: " .. newName)
end)

-- LEVEL CHANGER
local levelFrame = Instance.new("Frame")
levelFrame.Size = UDim2.new(1, -20, 0, 110)
levelFrame.Position = UDim2.new(0, 10, 0, 185)
levelFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
levelFrame.Parent = mainFrame
Instance.new("UICorner", levelFrame).CornerRadius = UDim.new(0, 8)

local levelLabel = Instance.new("TextLabel")
levelLabel.Size = UDim2.new(1, 0, 0, 30)
levelLabel.BackgroundTransparency = 1
levelLabel.Text = "🔹 LEVEL CHANGER"
levelLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
levelLabel.TextScaled = true
levelLabel.Font = Enum.Font.GothamBold
levelLabel.Parent = levelFrame

local levelBox = Instance.new("TextBox")
levelBox.Size = UDim2.new(1, -20, 0, 40)
levelBox.Position = UDim2.new(0, 10, 0, 35)
levelBox.PlaceholderText = "Ketik level baru (contoh: 999)"
levelBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
levelBox.TextColor3 = Color3.new(1, 1, 1)
levelBox.TextScaled = true
levelBox.Parent = levelFrame
Instance.new("UICorner", levelBox).CornerRadius = UDim.new(0, 6)

local levelBtn = Instance.new("TextButton")
levelBtn.Size = UDim2.new(0.9, 0, 0, 35)
levelBtn.Position = UDim2.new(0.05, 0, 0, 80)
levelBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
levelBtn.Text = "🚀 GANTI LEVEL"
levelBtn.TextColor3 = Color3.new(1, 1, 1)
levelBtn.TextScaled = true
levelBtn.Font = Enum.Font.GothamBold
levelBtn.Parent = levelFrame
Instance.new("UICorner", levelBtn).CornerRadius = UDim.new(0, 8)

levelBtn.MouseButton1Click:Connect(function()
    local newLevel = tonumber(levelBox.Text)
    if not newLevel then return end
    
    local leaderstats = player:WaitForChild("leaderstats", 10)
    if leaderstats then
        local levelValue = leaderstats:FindFirstChild("Level") or leaderstats:FindFirstChildWhichIsA("IntValue") or leaderstats:FindFirstChildWhichIsA("NumberValue")
        if levelValue then
            levelValue.Value = newLevel
            print("✅ Level berhasil diubah jadi: " .. newLevel)
        else
            print("⚠️ Ga nemu 'Level' di leaderstats. Coba cek nama statnya di game.")
        end
    else
        print("⚠️ leaderstats belum muncul, coba tunggu bentar lalu execute lagi.")
    end
end)

print("✅ hamzHub loaded! Enjoy bro di Fish It 🔥")
