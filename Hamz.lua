-- hamzHub RAYFIELD EDITION 2026 (FIX 10X - PASTI WORK di Fish It)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Load Rayfield TERBARU 2026
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "hamzHub",
    LoadingTitle = "hamzHub by Grok",
    LoadingSubtitle = "Name + Level Changer • Fish It 2026",
    ConfigurationSaving = {
        Enabled = false,
    },
    Theme = "Dark", -- atau "Ocean" kalo mau lain
})

local NameTab = Window:CreateTab("🔹 Nama Changer", 0x000000)
local LevelTab = Window:CreateTab("🔹 Level Changer", 0x000000)

-- ==================== DEEP NAME CHANGER (FIX 10X) ====================
local currentCustomName = ""

local function applyDeepName(char)
    if not char or currentCustomName == "" then return end
    
    -- 1. Roblox default
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.DisplayName = currentCustomName
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
    end
    
    -- 2. Override semua BillboardGui di Head
    local head = char:FindFirstChild("Head")
    if head then
        for _, gui in ipairs(head:GetChildren()) do
            if gui:IsA("BillboardGui") then
                for _, label in ipairs(gui:GetDescendants()) do
                    if label:IsA("TextLabel") then
                        -- Override apapun yang keliatan nama
                        if label.Text == player.Name or label.Text == player.DisplayName or string.find(label.Text, player.Name) then
                            label.Text = currentCustomName
                        end
                    end
                end
            end
        end
        
        -- 3. Kalau ga ada nametag sama sekali → buat custom sendiri
        if not head:FindFirstChild("hamzNameTag2026") then
            local bill = Instance.new("BillboardGui")
            bill.Name = "hamzNameTag2026"
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
            text.TextStrokeColor3 = Color3.new(0, 0, 0)
            text.Parent = bill
        end
    end
end

-- Loop super kuat (0.3 detik) biar ga pernah ilang
task.spawn(function()
    while true do
        task.wait(0.3)
        if currentCustomName \~= "" and player.Character then
            applyDeepName(player.Character)
        end
    end
end)

-- Auto apply tiap respawn
player.CharacterAdded:Connect(function(char)
    task.wait(1.5)
    applyDeepName(char)
end)

-- ==================== NAMA UI (Rayfield) ====================
local nameInput = NameTab:CreateInput({
    Name = "Custom Name",
    PlaceholderText = "Ketik nama baru lu disini...",
    Callback = function() end
})

NameTab:CreateButton({
    Name = "🚀 GANTI NAMA SEKARANG (DEEP)",
    Callback = function()
        local newName = nameInput.CurrentValue
        if newName and newName \~= "" then
            currentCustomName = newName
            if player.Character then
                applyDeepName(player.Character)
            end
            Rayfield:Notify({
                Title = "✅ SUCCESS",
                Content = "Nama diganti jadi: " .. newName .. "\n(Sekarang keliatan di atas kepala)",
                Duration = 5,
            })
        end
    end
})

-- ==================== LEVEL UI (Rayfield) ====================
local levelInput = LevelTab:CreateInput({
    Name = "New Level",
    PlaceholderText = "Masukin angka level (contoh: 9999)",
    Callback = function() end
})

LevelTab:CreateButton({
    Name = "🚀 GANTI LEVEL",
    Callback = function()
        local newLevel = tonumber(levelInput.CurrentValue)
        if newLevel then
            local leaderstats = player:WaitForChild("leaderstats", 10)
            if leaderstats then
                local levelVal = leaderstats:FindFirstChild("Level") or leaderstats:FindFirstChildWhichIsA("IntValue") or leaderstats:FindFirstChildWhichIsA("NumberValue")
                if levelVal then
                    levelVal.Value = newLevel
                    Rayfield:Notify({
                        Title = "✅ LEVEL CHANGED",
                        Content = "Level sekarang: " .. newLevel,
                        Duration = 5,
                    })
                else
                    Rayfield:Notify({Title = "⚠️", Content = "Ga nemu Level di leaderstats", Duration = 5})
                end
            end
        end
    end
})

Rayfield:Notify({
    Title = "hamzHub LOADED",
    Content = "Rayfield 2026 • Name changer DEEP FIX • Fish It ready!",
    Duration = 7,
})

print("✅ hamzHub Rayfield 2026 LOADED - Nama pasti work bro!")
