-- Protection by Vants
local _KEY=""
local _ok,_raw=pcall(function()
  return game:HttpGet("https://raw.githubusercontent.com/nitherhub-dotcom/vant-scripts/main/_s34bafda1ecde4b936863.txt")
end)
if not _ok or not _raw then error("[Vants] Could not verify key.") return end
local _st=_raw:match("^([^\n:]+)")
if not _st then error("[Vants] Bad status file.") return end
_st=_st:match("^%s*(.-)%s*$")
if _st~="ACTIVE" and _st~="REDEEMED" then error("[Vants] Key expired or revoked.") return end
-- Username check
local _locked=_raw:match("^[^:]+:(.+)")
if _locked and #_locked>0 then
  local _me=game.Players.LocalPlayer.Name
  if _me:lower()~=_locked:lower():match("^%s*(.-)%s*$") then
    game.Players.LocalPlayer:Kick("[Vants] This key is locked to another user.") return
  end
end

local _j0=5694
local _j1=579
local _j2=7665
local _j3=860
local _j4=9106
local ReplicatedStorage = game:GetService((string.char(82,101,112,108,105,99,97,116,101,100,83,116,111,114,97,103,101)))
local Players = game:GetService((string.char(80,108,97,121,101,114,115)))
local TweenService = game:GetService((string.char(84,119,101,101,110,83,101,114,118,105,99,101)))

local Gradient = require(ReplicatedStorage.Packages.Gradients)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local Animals = require(ReplicatedStorage.Datas.Animals)

local traitMap = {
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,56,57,48,52,49,57,51,48,55,53,57,52,54,52))] = {name = (string.char(84,97,99,111)), mult = 2},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,48,52,50,50,57,57,50,52,50,57,53,53,50,54))] = {name = (string.char(78,121,97,110)), mult = 5},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,57,57,49,56,49,55,56,53,55,54,54,53,57,56))] = {name = (string.char(71,97,108,97,99,116,105,99)), mult = 3},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,50,49,49,48,48,52,50,55,55,54,52,56,53,56))] = {name = (string.char(70,105,114,101,119,111,114,107,115)), mult = 5},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,49,48,55,50,51,51,56,55,52,56,51,57,51,57))] = {name = (string.char(90,111,109,98,105,101)), mult = 4},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,48,52,57,54,52,49,57,53,56,52,54,56,51,51))] = {name = (string.char(67,108,97,119,115)), mult = 4},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,50,49,51,51,50,52,51,51,50,55,50,57,55,54))] = {name = (string.char(71,108,105,116,99,104,101,100)), mult = 4},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,48,48,54,48,49,52,50,53,53,52,49,56,55,52))] = {name = (string.char(66,117,98,98,108,101,103,117,109)), mult = 3},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,49,56,50,56,51,51,52,54,48,51,55,55,56,56))] = {name = (string.char(70,105,114,101)), mult = 5},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,55,56,52,55,52,49,57,52,48,56,56,55,55,48))] = {name = (string.char(87,101,116)), mult = 1.5},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,56,51,54,50,55,52,55,53,57,48,57,56,54,57))] = {name = (string.char(83,110,111,119,121)), mult = 2},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,50,55,52,53,53,52,52,48,52,49,56,50,50,49))] = {name = (string.char(67,111,109,101,116,115,116,114,117,99,107)), mult = 2.5},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,57,55,55,50,53,55,52,52,50,53,50,54,48,56))] = {name = (string.char(69,120,112,108,111,115,105,118,101)), mult = 3},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,56,50,54,50,48,51,52,50,54,51,50,52,48,54))] = {name = (string.char(68,105,115,99,111)), mult = 4},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,51,52,54,53,53,52,49,53,54,56,49,57,50,54))] = {name = (string.char(49,48,66)), mult = 3},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,48,52,57,56,53,51,49,51,53,51,50,49,52,57))] = {name = (string.char(83,104,97,114,107,32,70,105,110)), mult = 3},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,49,53,54,54,52,56,48,52,50,49,50,48,57,54))] = {name = (string.char(77,97,116,116,101,111,32,72,97,116)), mult = 3.5},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,55,53,54,53,48,56,49,54,51,52,49,50,50,57))] = {name = (string.char(66,114,97,122,105,108)), mult = 5},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,49,53,48,48,49,49,49,55,56,55,54,53,51,52))] = {name = (string.char(83,108,101,101,112,121)), mult = 0},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,51,57,55,50,57,54,57,54,50,52,55,49,52,52))] = {name = (string.char(76,105,103,104,116,110,105,110,103)), mult = 5},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,49,48,57,49,48,53,49,56,52,56,49,48,53,50))] = {name = (string.char(85,70,79)), mult = 2},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,49,55,52,55,56,57,55,49,51,50,53,54,57,54))] = {name = (string.char(83,112,105,100,101,114)), mult = 3.5},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,56,52,55,51,49,49,49,56,53,54,54,52,57,51))] = {name = (string.char(83,116,114,97,119,98,101,114,114,121)), mult = 7},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,49,57,53,57,49,55,52,50,53,48,52,50,53,49))] = {name = (string.char(80,97,105,110,116)), mult = 5},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,56,57,53,57,49,56,51,56,50,50,49,51,51,53))] = {name = (string.char(83,107,101,108,101,116,111,110)), mult = 3},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,57,53,49,50,56,48,51,57,55,57,51,56,52,53))] = {name = (string.char(83,111,109,98,114,101,114,111)), mult = 4},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,48,51,54,49,48,48,51,55,48,48,52,57,49,49))] = {name = (string.char(84,105,101)), mult = 3.75},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,50,51,57,54,52,48,52,56,54,48,54,56,55,52))] = {name = (string.char(87,105,116,99,104,32,72,97,116)), mult = 3},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,57,51,51,53,48,52,49,52,57,55,52,53,56,57))] = {name = (string.char(73,110,100,111,110,101,115,105,97)), mult = 4},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,49,52,55,52,56,50,50,49,55,54,49,53,52,57))] = {name = (string.char(77,101,111,119,108)), mult = 6},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,50,51,49,49,53,56,52,51,55,49,57,51,56,51))] = {name = (string.char(82,73,80,32,71,114,97,118,101,115,116,111,110,101)), mult = 3.5},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,57,55,48,53,52,55,54,53,50,55,51,56,53,55))] = {name = (string.char(74,97,99,107,111,108,97,110,116,101,114,110,32,80,101,116)), mult = 4.5},
    [(string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,56,56,51,55,53,48,52,51,55,51,51,53,56,50))] = {name = (string.char(83,97,110,116,97,32,72,97,116)), mult = 4}
}

local mutationMap = {
    [(string.char(71,111,108,100))] = {
        mult = 0.25,
        displayText = (string.char(71,111,108,100)),
        richText = "<font color=\"#FFDE59\(string.char(62,71,111,108,100,60,47,102,111,110,116,62)),
        color = Color3.fromRGB(255, 222, 89),
        icon = (string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,51,54,49,51,51,48,53,55,56,50,50,52,48,55))
    },
    [(string.char(68,105,97,109,111,110,100))] = {
        mult = 0.5,
        displayText = (string.char(68,105,97,109,111,110,100)),
        richText = "<font color=\"#25C4FE\(string.char(62,68,105,97,109,111,110,100,60,47,102,111,110,116,62)),
        color = Color3.fromRGB(37, 196, 254),
        icon = (string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,48,48,56,55,53,55,48,57,53,52,55,48,49,53))
    },
    [(string.char(66,108,111,111,100,114,111,116))] = {
        mult = 1,
        displayText = (string.char(66,108,111,111,100,114,111,116)),
        richText = "<font color=\"#8A3B3C\(string.char(62,66,108,111,111,100,114,111,116,60,47,102,111,110,116,62)),
        color = Color3.fromRGB(145, 0, 27),
        icon = (string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,55,53,50,49,50,48,51,54,55,56,52,48,51,49))
    },
    [(string.char(82,97,105,110,98,111,119))] = {
        mult = 9,
        displayText = (string.char(82,97,105,110,98,111,119)),
        richText = "<font color=\"#ff00fb\(string.char(62,82,97,105,110,98,111,119,60,47,102,111,110,116,62)),
        color = Color3.fromRGB(255, 0, 251),
        icon = (string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,56,51,48,55,56,55,49,52,48,57,48,49,57,50))
    },
    [(string.char(67,97,110,100,121))] = {
        mult = 3,
        displayText = (string.char(67,97,110,100,121)),
        richText = "<font color=\"#ff46f6\(string.char(62,67,97,110,100,121,60,47,102,111,110,116,62)),
        color = Color3.fromRGB(255, 70, 246),
        icon = (string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,56,52,55,57,55,54,55,51,54,57,56,54,56,53))
    },
    [(string.char(76,97,118,97))] = {
        mult = 5,
        displayText = (string.char(76,97,118,97)),
        richText = "<font color=\"#ff7700\(string.char(62,76,97,118,97,60,47,102,111,110,116,62)),
        color = Color3.fromRGB(255, 149, 0),
        icon = (string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,55,48,56,48,48,52,55,49,52,57,56,50,51,49))
    },
    [(string.char(71,97,108,97,120,121))] = {
        mult = 6,
        displayText = (string.char(71,97,108,97,120,121)),
        richText = "<font color=\"#aa3cff\(string.char(62,71,97,108,97,120,121,60,47,102,111,110,116,62)),
        color = Color3.fromRGB(170, 60, 255),
        icon = (string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,51,57,51,51,49,54,55,49,52,48,53,49,51,56))
    },
    [(string.char(89,105,110,32,89,97,110,103))] = {
        mult = 6.5,
        displayText = (string.char(89,105,110,32,89,97,110,103)),
        richText = "<stroke color=\"#fff\" thickness=\"2\"><font color=\"#000\">Yin</font></stroke> <stroke color=\"#000\" thickness=\"2\"><font color=\"#fff\(string.char(62,89,97,110,103,60,47,102,111,110,116,62,60,47,115,116,114,111,107,101,62)),
        useRichText = true,
        color = Color3.fromRGB(255, 255, 255),
        icon = (string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,49,50,57,57,54,49,55,56,51,48,50,51,48,50))
    },
    [(string.char(89,105,110,89,97,110,103))] = {
        mult = 6.5,
        displayText = (string.char(89,105,110,32,89,97,110,103)),
        richText = "<stroke color=\"#fff\" thickness=\"2\"><font color=\"#000\">Yin</font></stroke> <stroke color=\"#000\" thickness=\"2\"><font color=\"#fff\(string.char(62,89,97,110,103,60,47,102,111,110,116,62,60,47,115,116,114,111,107,101,62)),
        useRichText = true,
        color = Color3.fromRGB(255, 255, 255),
        icon = (string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,49,50,57,57,54,49,55,56,51,48,50,51,48,50))
    },
    [(string.char(82,97,100,105,111,97,99,116,105,118,101))] = {
        mult = 7.5,
        displayText = (string.char(82,97,100,105,111,97,99,116,105,118,101)),
        richText = "<font color=\"#68f500\(string.char(62,82,97,100,105,111,97,99,116,105,118,101,60,47,102,111,110,116,62)),
        useRichText = false,
        color = Color3.fromRGB(104, 245, 0),
        icon = (string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,51,52,56,48,57,53,49,48,52,52,54,55,53,52))
    }
}

local traitList = {}
for assetId, data in pairs(traitMap) do
    table.insert(traitList, data.name)
end
table.sort(traitList)

local function formatNumber(num)
    local suffixes = {(string.char()), (string.char(75)), (string.char(77)), (string.char(66)), (string.char(84)), (string.char(81))}
    local tier = 1
    
    while num >= 1000 and tier < #suffixes do
        num = num / 1000
        tier = tier + 1
    end
    
    if num % 1 == 0 then
        return string.format((string.char(37,100,37,115)), num, suffixes[tier])
    else
        return string.format((string.char(37,46,49,102,37,115)), num, suffixes[tier])
    end
end

local function parseCurrency(str)
    str = str:gsub((string.char(60,91,94,62,93,43,62)), (string.char()))
    str = str:gsub((string.char(37,36)), (string.char()))
    str = str:gsub((string.char(44)), (string.char()))
    str = str:gsub((string.char(91,94,37,100,37,46,37,97,93)), (string.char()))
    
    local numStr, suffix = str:match((string.char(94,40,37,100,42,37,46,63,37,100,43,41,40,37,97,42,41)))
    local num = tonumber(numStr) or 0
    
    suffix = suffix:upper()
    local multipliers = {
        K = 1000,
        M = 1000000,
        B = 1000000000,
        T = 1000000000000,
        Q = 1000000000000000
    }
    
    return num * (multipliers[suffix] or 1)
end

local Controllers = ReplicatedStorage:WaitForChild((string.char(67,111,110,116,114,111,108,108,101,114,115)))
local Utils = ReplicatedStorage:WaitForChild((string.char(85,116,105,108,115)))
local SoundController = require(Controllers.SoundController)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local LeftBottom = PlayerGui:WaitForChild((string.char(76,101,102,116,66,111,116,116,111,109))):WaitForChild((string.char(76,101,102,116,66,111,116,116,111,109)))
local CashoutFrame = LeftBottom:FindFirstChild((string.char(67,97,115,104,111,117,116)))

local cashoutTweenInfo = TweenInfo.new(5, Enum.EasingStyle.Linear)

local function showCashout(text, isGreen, playSound)
    if not CashoutFrame or not CashoutFrame.Template or not CashoutFrame.Template:IsA((string.char(84,101,120,116,76,97,98,101,108))) then
        return
    end
    
    local label = CashoutFrame.Template:Clone()
    label.Text = text
    
    local color = isGreen and Color3.fromRGB(13, 255, 0) or Color3.fromRGB(255, 0, 0)
    label.TextColor3 = color
    label.Visible = true
    label.Parent = CashoutFrame
    
    local textTween = TweenService:Create(label, cashoutTweenInfo, {TextTransparency = 1})
    local strokeTween = TweenService:Create(label.UIStroke, cashoutTweenInfo, {Transparency = 1})
    
    textTween.Completed:Once(function()
        label:Destroy()
    end)
    
    textTween:Play()
    strokeTween:Play()
    
    if playSound and isGreen then
        SoundController:PlaySound((string.char(83,111,117,110,100,115,46,83,102,120,46,67,97,115,104,111,117,116)))
    end
end

local function getAnimalData(animalName)
    return Animals[animalName] or {}
end

local function getTraitIconByName(traitName)
    for assetId, data in pairs(traitMap) do
        if data.name == traitName then
            return assetId
        end
    end
    return nil
end

local function applyMutationVisuals(clonedAnimal, mutationName)
    if not mutationName or mutationName == (string.char(78,111,110,101)) then return end
    
    local mutationData = mutationMap[mutationName]
    if not mutationData then return end
    
    local MutationsData = ReplicatedStorage.Datas:FindFirstChild((string.char(77,117,116,97,116,105,111,110,115)))
    if MutationsData then
        local success, mutationModule = pcall(function()
            return require(MutationsData)
        end)
        
        if success and mutationModule then
            local mutationInfo = mutationModule[mutationName]
            
            if mutationInfo and mutationInfo.Palettes then
                local palette = mutationInfo.Palettes[1]
                if palette then
                    local colorIndex = 1
                    for _, part in ipairs(clonedAnimal:GetDescendants()) do
                        if part:IsA((string.char(66,97,115,101,80,97,114,116))) or part:IsA((string.char(77,101,115,104,80,97,114,116))) then
                            part.Color = palette[colorIndex]
                            colorIndex = (colorIndex % #palette) + 1
                        end
                    end
                end
            end
        end
    end
end

local function spawnAnimal(animalName, selectedTraits, selectedMutation)
    local animalData = Animals[animalName]
    if not animalData then
        return false, (string.char(105,110,118,97,108,105,100,32,98,114,97,105,110,114,111,116))
    end
    
    local animalModel = ReplicatedStorage.Models.Animals:FindFirstChild(animalName)
    if not animalModel then
        return false, (string.char(105,110,118,97,108,105,100,32,98,114,97,105,110,114,111,116))
    end
    
    local foundPlot = false
    local spawnCFrame = nil
    local spawnAttachment = nil
    local claimFrame = nil
    local hitbox = nil
    
    for _, plot in ipairs(workspace.Plots:GetChildren()) do
        local plotSign = plot:FindFirstChild((string.char(80,108,111,116,83,105,103,110)))
        if plotSign then
            local surfaceGui = plotSign:FindFirstChild((string.char(83,117,114,102,97,99,101,71,117,105)))
            if surfaceGui then
                local frame = surfaceGui:FindFirstChild((string.char(70,114,97,109,101)))
                if frame then
                    local textLabel = frame:FindFirstChild((string.char(84,101,120,116,76,97,98,101,108)))
                    if textLabel then
                        local ownerText = textLabel.Text:gsub((string.char(94,37,115,42,40,46,45,41,37,115,42,36)), (string.char(37,49)))
                        
                        if string.find(ownerText:lower(), LocalPlayer.Name:lower()) or 
                           ownerText == LocalPlayer.Name or 
                           string.find(ownerText, LocalPlayer.DisplayName) then
                            
                            local podiums = plot:FindFirstChild((string.char(65,110,105,109,97,108,80,111,100,105,117,109,115)))
                            if podiums then
                                local podiumList = {}
                                
                                for _, child in ipairs(podiums:GetChildren()) do
                                    if child:IsA((string.char(77,111,100,101,108))) and tonumber(child.Name) then
                                        table.insert(podiumList, child)
                                    end
                                end
                                
                                table.sort(podiumList, function(a, b)
                                    return tonumber(a.Name) < tonumber(b.Name)
                                end)
                                
                                for _, podium in ipairs(podiumList) do
                                    local base = podium:FindFirstChild((string.char(66,97,115,101)))
                                    if base then
                                        local spawn = base:FindFirstChild((string.char(83,112,97,119,110)))
                                        if spawn then
                                            local attachment = spawn:FindFirstChild((string.char(65,116,116,97,99,104,109,101,110,116)))
                                            local hasAnimal = false
                                            
                                            for _, obj in ipairs(spawn:GetChildren()) do
                                                if obj:IsA((string.char(77,111,100,101,108))) and obj.Name ~= (string.char(65,116,116,97,99,104,109,101,110,116)) then
                                                    hasAnimal = true
                                                    break
                                                end
                                            end
                                            
                                            if not hasAnimal then
                                                for _, obj in ipairs(podium:GetChildren()) do
                                                    if obj:IsA((string.char(77,111,100,101,108))) and Animals[obj.Name] then
                                                        hasAnimal = true
                                                        break
                                                    end
                                                end
                                            end
                                            
                                            if not attachment and not hasAnimal then
                                                spawnCFrame = spawn.CFrame * CFrame.new(0, -1.5, 0)
                                                spawnAttachment = spawn
                                                
                                                claimFrame = podium:FindFirstChild((string.char(67,108,97,105,109))) and 
                                                            podium.Claim:FindFirstChild((string.char(77,97,105,110))) and
                                                            podium.Claim.Main:FindFirstChild((string.char(67,111,108,108,101,99,116)))
                                                
                                                hitbox = podium:FindFirstChild((string.char(67,108,97,105,109))) and
                                                        podium.Claim:FindFirstChild((string.char(72,105,116,98,111,120)))
                                                
                                                foundPlot = true
                                                break
                                            end
                                        end
                                    end
                                end
                                
                                if foundPlot then break end
                            end
                        end
                    end
                end
            end
        end
    end
    
    if not foundPlot then
        return false, (string.char(102,117,108,108,32,98,97,115,101))
    end
    
    local clonedAnimal = animalModel:Clone()
    clonedAnimal:PivotTo(spawnCFrame)
    clonedAnimal.Parent = workspace
    
    for _, descendant in ipairs(clonedAnimal:GetDescendants()) do
        if descendant:IsA((string.char(66,97,115,101,80,97,114,116))) then
            descendant.Anchored = true
        end
    end
    
    local animController = clonedAnimal:FindFirstChildOfClass((string.char(65,110,105,109,97,116,105,111,110,67,111,110,116,114,111,108,108,101,114)))
    local idleAnim = ReplicatedStorage.Animations.Animals:FindFirstChild(animalName)
    if idleAnim then
        idleAnim = idleAnim:FindFirstChild((string.char(73,100,108,101)))
    end
    
    if animController and idleAnim then
        local track = animController:LoadAnimation(idleAnim)
        track:Play()
    end
    
    local animalSoundsFolder = ReplicatedStorage.Sounds:FindFirstChild((string.char(65,110,105,109,97,108,115)))
    if animalSoundsFolder then
        local animalSound = animalSoundsFolder:FindFirstChild(animalName)
        if animalSound and animalSound:IsA((string.char(83,111,117,110,100))) then
            local soundClone = animalSound:Clone()
            soundClone.Parent = clonedAnimal.PrimaryPart or clonedAnimal:FindFirstChildWhichIsA((string.char(66,97,115,101,80,97,114,116)))
            soundClone:Play()
            soundClone.Ended:Connect(function()
                soundClone:Destroy()
            end)
        end
    end
    
    if selectedMutation and selectedMutation ~= (string.char(78,111,110,101)) then
        applyMutationVisuals(clonedAnimal, selectedMutation)
    end
    
    if selectedTraits and clonedAnimal.PrimaryPart then
        local traitsModelsFolder = ReplicatedStorage.Models:FindFirstChild((string.char(84,114,97,105,116,115)))
        local traitsVfxFolder = ReplicatedStorage.Vfx:FindFirstChild((string.char(84,114,97,105,116,115)))
        local traitsPerAnimalFolder = ReplicatedStorage.Models:FindFirstChild((string.char(84,114,97,105,116,115,80,101,114,65,110,105,109,97,108)))
        
        for _, traitName in ipairs(selectedTraits) do
            local customPlacement = nil
            if traitsPerAnimalFolder then
                local animalTraitsFolder = traitsPerAnimalFolder:FindFirstChild(animalName)
                if animalTraitsFolder then
                    customPlacement = animalTraitsFolder:FindFirstChild(traitName)
                end
            end
            
            if traitsVfxFolder then
                local traitVfx = traitsVfxFolder:FindFirstChild(traitName)
                if traitVfx then
                    for _, vfxItem in ipairs(traitVfx:GetChildren()) do
                        local vfxClone = vfxItem:Clone()
                        
                        if customPlacement and customPlacement:IsA((string.char(65,116,116,97,99,104,109,101,110,116))) then
                            vfxClone.Parent = customPlacement
                        else
                            if vfxClone:IsA((string.char(80,97,114,116,105,99,108,101,69,109,105,116,116,101,114))) or vfxClone:IsA((string.char(66,101,97,109))) or vfxClone:IsA((string.char(84,114,97,105,108))) then
                                local attachment = clonedAnimal.PrimaryPart:FindFirstChildOfClass((string.char(65,116,116,97,99,104,109,101,110,116)))
                                if not attachment then
                                    attachment = Instance.new((string.char(65,116,116,97,99,104,109,101,110,116)))
                                    attachment.Parent = clonedAnimal.PrimaryPart
                                end
                                vfxClone.Parent = attachment
                            else
                                vfxClone.Parent = clonedAnimal.PrimaryPart
                            end
                        end
                        
                        -- Enable the effect
                        if vfxClone:IsA((string.char(80,97,114,116,105,99,108,101,69,109,105,116,116,101,114))) or vfxClone:IsA((string.char(84,114,97,105,108))) or vfxClone:IsA((string.char(66,101,97,109))) then
                            vfxClone.Enabled = true
                        end
                    end
                end
            end
            
            if traitsModelsFolder then
                local traitModel = traitsModelsFolder:FindFirstChild(traitName)
                
                if traitModel then
                    local traitClone = traitModel:Clone()
                    traitClone.Parent = clonedAnimal
                    
                    if traitClone:IsA((string.char(77,111,100,101,108))) then
                        if customPlacement then
                            if customPlacement:IsA((string.char(65,116,116,97,99,104,109,101,110,116))) then
                                traitClone:PivotTo(customPlacement.WorldCFrame)
                            elseif customPlacement:IsA((string.char(66,97,115,101,80,97,114,116))) then
                                traitClone:PivotTo(customPlacement.CFrame)
                            end
                        elseif traitClone.PrimaryPart then
                            traitClone:PivotTo(clonedAnimal.PrimaryPart.CFrame)
                        else
                            local mainPart = traitClone:FindFirstChildWhichIsA((string.char(66,97,115,101,80,97,114,116)))
                            if mainPart then
                                mainPart.CFrame = clonedAnimal.PrimaryPart.CFrame
                            end
                        end
                        
                        for _, part in ipairs(traitClone:GetDescendants()) do
                            if part:IsA((string.char(66,97,115,101,80,97,114,116))) then
                                part.Anchored = false
                                part.CanCollide = false
                                part.CanQuery = false
                                
                                local weld = Instance.new((string.char(87,101,108,100,67,111,110,115,116,114,97,105,110,116)))
                                weld.Part0 = clonedAnimal.PrimaryPart
                                weld.Part1 = part
                                weld.Parent = part
                                
                                for _, desc in ipairs(part:GetDescendants()) do
                                    if desc:IsA((string.char(80,97,114,116,105,99,108,101,69,109,105,116,116,101,114))) or desc:IsA((string.char(84,114,97,105,108))) or desc:IsA((string.char(66,101,97,109))) then
                                        desc.Enabled = true
                                    end
                                end
                            end
                        end
                    elseif traitClone:IsA((string.char(66,97,115,101,80,97,114,116))) then
                        if customPlacement and customPlacement:IsA((string.char(66,97,115,101,80,97,114,116))) then
                            traitClone.CFrame = customPlacement.CFrame
                        else
                            traitClone.CFrame = clonedAnimal.PrimaryPart.CFrame
                        end
                        traitClone.Anchored = false
                        traitClone.CanCollide = false
                        traitClone.CanQuery = false
                        
                        local weld = Instance.new((string.char(87,101,108,100,67,111,110,115,116,114,97,105,110,116)))
                        weld.Part0 = clonedAnimal.PrimaryPart
                        weld.Part1 = traitClone
                        weld.Parent = traitClone
                        
                        for _, desc in ipairs(traitClone:GetDescendants()) do
                            if desc:IsA((string.char(80,97,114,116,105,99,108,101,69,109,105,116,116,101,114))) or desc:IsA((string.char(84,114,97,105,108))) or desc:IsA((string.char(66,101,97,109))) then
                                desc.Enabled = true
                            end
                        end
                    end
                end
            end
        end
    end
    
    local totalGeneration = 0
    local connection = nil
    local attachmentMarker = nil
    local lastCollectTime = 0
    
    local marker = Instance.new((string.char(65,116,116,97,99,104,109,101,110,116)))
    marker.Name = (string.char(65,116,116,97,99,104,109,101,110,116))
    marker.Parent = spawnAttachment
    attachmentMarker = marker
    
    if claimFrame and claimFrame:FindFirstChild((string.char(79,102,102,108,105,110,101))) then
        local offline = claimFrame.Offline
        if offline:IsA((string.char(71,117,105,79,98,106,101,99,116))) then
            offline.Visible = false
        end
    end
    
    if clonedAnimal.PrimaryPart then
        local proximityPrompt = Instance.new((string.char(80,114,111,120,105,109,105,116,121,80,114,111,109,112,116)))
        proximityPrompt.ObjectText = animalData.DisplayName
        proximityPrompt.ActionText = (string.char(83,101,108,108,58,32,36)) .. formatNumber(animalData.Price / 2)
        proximityPrompt.KeyboardKeyCode = Enum.KeyCode.E
        proximityPrompt.HoldDuration = 1.5
        proximityPrompt.MaxActivationDistance = 10
        proximityPrompt.Parent = clonedAnimal.PrimaryPart
        
        proximityPrompt.Triggered:Connect(function(player)
            if player ~= LocalPlayer then return end
            
            local sellPrice = animalData.Price / 2
            
            local currencyLabel = PlayerGui.LeftBottom.LeftBottom:FindFirstChild((string.char(67,117,114,114,101,110,99,121)))
            if currencyLabel and currencyLabel:IsA((string.char(84,101,120,116,76,97,98,101,108))) then
                local currentMoney = parseCurrency(currencyLabel.Text)
                currencyLabel.Text = (string.char(36)) .. formatNumber(currentMoney + sellPrice)
            end
            
            local leaderstats = LocalPlayer:FindFirstChild((string.char(108,101,97,100,101,114,115,116,97,116,115)))
            local cash = leaderstats and leaderstats:FindFirstChild((string.char(67,97,115,104)))
            if cash and (cash:IsA((string.char(78,117,109,98,101,114,86,97,108,117,101))) or cash:IsA((string.char(73,110,116,86,97,108,117,101)))) then
                cash.Value = cash.Value + sellPrice
            end
            
            showCashout((string.char(43,36)) .. formatNumber(sellPrice), true, true)
            
            totalGeneration = 0
            if connection then
                connection:Disconnect()
                connection = nil
            end
            if claimFrame then
                claimFrame.Enabled = false
                local collectLabel = claimFrame:FindFirstChild((string.char(67,111,108,108,101,99,116)))
                if collectLabel then
                    collectLabel.Text = "Collect<br/><font color=\"#73ff00\(string.char(62,36,48,60,47,102,111,110,116,62))
                end
            end
            clonedAnimal:Destroy()
            if attachmentMarker and attachmentMarker.Parent then
                attachmentMarker:Destroy()
                attachmentMarker = nil
            end
        end)
    end
    
    local generationRate = animalData.Generation or 0
    local traitBonus = 0
    
    if selectedTraits then
        for _, traitName in ipairs(selectedTraits) do
            for assetId, data in pairs(traitMap) do
                if data.name == traitName then
                    traitBonus = traitBonus + (generationRate * data.mult)
                    break
                end
            end
        end
    end
    
    local mutationBonus = 0
    if selectedMutation and selectedMutation ~= (string.char(78,111,110,101)) and mutationMap[selectedMutation] then
        mutationBonus = generationRate * mutationMap[selectedMutation].mult
    end
    
    local totalGenRate = generationRate + traitBonus + mutationBonus
    
    if claimFrame and hitbox then
        local collectLabel = claimFrame:FindFirstChild((string.char(67,111,108,108,101,99,116)))
        if collectLabel and collectLabel:IsA((string.char(84,101,120,116,76,97,98,101,108))) then
            claimFrame.Enabled = true
            collectLabel.Text = "Collect<br/><font color=\"#73ff00\(string.char(62,36,48,60,47,102,111,110,116,62))
            
            if hitbox:IsA((string.char(66,97,115,101,80,97,114,116))) then
                hitbox.CanCollide = false
                hitbox.CanQuery = true
            end
            
            hitbox.Touched:Connect(function(hit)
                local player = Players:GetPlayerFromCharacter(hit.Parent)
                if player == LocalPlayer and clonedAnimal and clonedAnimal.Parent then
                    local currentTime = os.time()
                    if currentTime - lastCollectTime >= 1 and totalGeneration > 0 then
                        lastCollectTime = currentTime
                        
                        local currencyLabel = PlayerGui.LeftBottom.LeftBottom:FindFirstChild((string.char(67,117,114,114,101,110,99,121)))
                        if currencyLabel and currencyLabel:IsA((string.char(84,101,120,116,76,97,98,101,108))) then
                            local currentMoney = parseCurrency(currencyLabel.Text)
                            currencyLabel.Text = (string.char(36)) .. formatNumber(currentMoney + totalGeneration)
                        end
                        
                        local leaderstats = LocalPlayer:FindFirstChild((string.char(108,101,97,100,101,114,115,116,97,116,115)))
                        local cash = leaderstats and leaderstats:FindFirstChild((string.char(67,97,115,104)))
                        if cash and (cash:IsA((string.char(78,117,109,98,101,114,86,97,108,117,101))) or cash:IsA((string.char(73,110,116,86,97,108,117,101)))) then
                            cash.Value = cash.Value + totalGeneration
                        end
                        
                        showCashout((string.char(43,36)) .. formatNumber(totalGeneration), true, true)
                        totalGeneration = 0
                        collectLabel.Text = "Collect<br/><font color=\"#73ff00\(string.char(62,36,48,60,47,102,111,110,116,62))
                    end
                end
            end)
            
            claimFrame.Changed:Connect(function(property)
                if property == (string.char(69,110,97,98,108,101,100)) and claimFrame.Enabled == false then
                    claimFrame.Enabled = true
                end
            end)
            
            task.spawn(function()
                while claimFrame and claimFrame.Parent and claimFrame.Enabled and 
                      clonedAnimal and clonedAnimal.Parent do
                    task.wait(1)
                    totalGeneration = totalGeneration + totalGenRate
                    collectLabel.Text = "Collect<br/><font color=\"#73ff00\(string.char(62,36)) .. 
                                       formatNumber(totalGeneration) .. (string.char(60,47,102,111,110,116,62))
                end
            end)
        end
    end
    
    local overheadTemplate = ReplicatedStorage.Overheads:FindFirstChild((string.char(65,110,105,109,97,108,79,118,101,114,104,101,97,100)))
    local head = clonedAnimal:FindFirstChild((string.char(72,101,97,100))) or clonedAnimal.PrimaryPart
    
    if overheadTemplate and head then
        local overhead = overheadTemplate:Clone()
        overhead.StudsOffset = Vector3.new(0, 7, 0)
        overhead.Adornee = head
        overhead.Parent = head
        overhead.AlwaysOnTop = true
        overhead.MaxDistance = 200
        
        local mutation = overhead:FindFirstChild((string.char(77,117,116,97,116,105,111,110)), true)
        if mutation and mutation:IsA((string.char(71,117,105,79,98,106,101,99,116))) then
            if selectedMutation and selectedMutation ~= (string.char(78,111,110,101)) then
                local mutationInfo = mutationMap[selectedMutation]
                if mutationInfo then
                    -- Use rich text formatting with proper handling
                    if mutationInfo.useRichText == true and mutationInfo.richText then
                        mutation.Text = mutationInfo.richText
                        mutation.RichText = true
                    elseif mutationInfo.richText then
                        mutation.Text = mutationInfo.richText
                        mutation.RichText = true
                    else
                        mutation.Text = mutationInfo.displayText or selectedMutation
                        mutation.TextColor3 = mutationInfo.color or Color3.new(1, 1, 1)
                    end
                else
                    mutation.Text = selectedMutation
                end
                mutation.Visible = true
                
                if selectedMutation == (string.char(82,97,105,110,98,111,119)) then
                    local rainbowColorSeq = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)),
                        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 0, 242)),
                        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 132, 255)),
                        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(17, 255, 0)),
                        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(251, 255, 0)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
                    })
                    local transparency = NumberSequence.new(0)
                    local rainbowGradient = Gradient.new(mutation, rainbowColorSeq, transparency)
                    rainbowGradient:SetOffsetSpeed(0.5, 0.5)
                end
            else
                mutation.Visible = false
            end
        end
        
        local function updateOverheadText(fieldName, value)
            local field = overhead:FindFirstChild(fieldName, true)
            if field then
                field.Text = value
            end
        end
        
        updateOverheadText((string.char(68,105,115,112,108,97,121,78,97,109,101)), animalData.DisplayName)
        updateOverheadText((string.char(82,97,114,105,116,121)), animalData.Rarity)
        updateOverheadText((string.char(80,114,105,99,101)), (string.char(36)) .. formatNumber(animalData.Price))
        updateOverheadText((string.char(71,101,110,101,114,97,116,105,111,110)), (string.char(36)) .. formatNumber(totalGenRate) .. (string.char(47,115)))
        
        local rarityConfig = Rarities[animalData.Rarity]
        if rarityConfig then
            local rarityLabel = overhead:FindFirstChild((string.char(82,97,114,105,116,121)), true)
            if rarityLabel then
                if animalData.Rarity == (string.char(66,114,97,105,110,114,111,116,32,71,111,100)) then
                    rarityLabel.FontFace = Font.new((string.char(114,98,120,97,115,115,101,116,58,47,47,102,111,110,116,115,47,102,97,109,105,108,105,101,115,47,71,111,116,104,97,109,83,83,109,46,106,115,111,110)), Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
                    rarityLabel.TextColor3 = Color3.fromRGB(255, 0, 221)
                    rarityLabel.TextStrokeTransparency = 0
                    rarityLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                    
                    local uiStroke = rarityLabel:FindFirstChild((string.char(85,73,83,116,114,111,107,101)))
                    if uiStroke then
                        local gradient = uiStroke:FindFirstChild((string.char(85,73,71,114,97,100,105,101,110,116)))
                        if gradient then
                            gradient.Enabled = true
                        end
                    end
                    
                elseif animalData.Rarity == (string.char(83,101,99,114,101,116)) then
                    rarityLabel.FontFace = Font.new((string.char(114,98,120,97,115,115,101,116,58,47,47,102,111,110,116,115,47,102,97,109,105,108,105,101,115,47,71,111,116,104,97,109,83,83,109,46,106,115,111,110)), Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
                    rarityLabel.TextColor3 = Color3.new(1, 1, 1)
                    rarityLabel.TextStrokeTransparency = 0
                    rarityLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                    
                    local uiStroke = rarityLabel:FindFirstChild((string.char(85,73,83,116,114,111,107,101)))
                    if uiStroke then
                        local gradient = uiStroke:FindFirstChild((string.char(85,73,71,114,97,100,105,101,110,116)))
                        if gradient then
                            gradient.Enabled = true
                        end
                    end
                    
                    if EasyVisuals then
                        EasyVisuals.new(rarityLabel, rarityConfig.EasyVisualsPresset, 0.6, nil, true, Color3.new(0, 0, 0))
                    end
                    
                elseif rarityConfig.EasyVisualsPresset and EasyVisuals then
                    EasyVisuals.new(rarityLabel, rarityConfig.EasyVisualsPresset, nil, nil, true, rarityConfig.Color)
                else
                    rarityLabel.TextColor3 = rarityConfig.Color
                end
            end
        end
        
        local traitsContainer = overhead:FindFirstChild((string.char(84,114,97,105,116,115)))
        if traitsContainer then
            traitsContainer.Visible = true
            local template = traitsContainer:FindFirstChild((string.char(84,101,109,112,108,97,116,101)))
            
            if selectedTraits and #selectedTraits > 0 then
                for _, traitName in ipairs(selectedTraits) do
                    local iconId = getTraitIconByName(traitName)
                    if iconId and template then
                        local icon = template:Clone()
                        icon.Image = iconId
                        icon.Visible = true
                        icon.Parent = traitsContainer
                        icon.Name = traitName .. (string.char(95,73,99,111,110))
                    end
                end
            end
        end
    end
    
    return true, clonedAnimal
end

local Library = loadstring(game:HttpGet((string.char(104,116,116,112,115,58,47,47,112,97,115,116,101,102,121,46,97,112,112,47,76,100,111,106,78,90,106,57,47,114,97,119))))()

local Window = Library:CreateWindow({
    Name = (string.char(66,114,97,105,110,114,111,116,32,83,112,97,119,110,101,114)),
    Theme = (string.char(71,114,101,101,110))
})

local excludedAnimals = {
    [(string.char(83,101,99,114,101,116,32,76,117,99,107,121,32,66,108,111,99,107))] = true,
    [(string.char(67,104,105,109,112,97,110,122,105,110,105,32,83,112,105,100,101,114,105,110,105))] = true,
    [(string.char(77,121,116,104,105,99,32,76,117,99,107,121,32,66,108,111,99,107))] = true,
    [(string.char(66,114,97,105,110,114,111,116,32,71,111,100,32,76,117,99,107,121,32,66,108,111,99,107))] = true
}

local animalList = {}
for name in pairs(Animals) do
    if not excludedAnimals[name] then
        table.insert(animalList, name)
    end
end

local animalsByRarity = {}
for _, name in ipairs(animalList) do
    local rarity = Animals[name].Rarity or (string.char(85,110,107,110,111,119,110))
    animalsByRarity[rarity] = animalsByRarity[rarity] or {}
    table.insert(animalsByRarity[rarity], name)
end

local rarityOrder = {(string.char(83,101,99,114,101,116)), (string.char(66,114,97,105,110,114,111,116,32,71,111,100)), (string.char(77,121,116,104,105,99)), (string.char(76,101,103,101,110,100,97,114,121)), (string.char(69,112,105,99)), (string.char(82,97,114,101)), (string.char(67,111,109,109,111,110)), (string.char(85,110,107,110,111,119,110))}
local sortedList = {}
for _, rarity in ipairs(rarityOrder) do
    for _, name in ipairs(animalsByRarity[rarity] or {}) do
        table.insert(sortedList, name)
    end
end
animalList = sortedList

local mutationList = {(string.char(78,111,110,101))}
for mutName in pairs(mutationMap) do
    table.insert(mutationList, mutName)
end
table.sort(mutationList)

local SpawnerTab = Window:CreateTab((string.char(83,80,65,87,78,69,82)), (string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,48,55,50,51,52,50,53,54,49,53)))
local SpawnerSection = SpawnerTab:CreateSection((string.char(66,114,97,105,110,114,111,116,32,83,112,97,119,110,101,114)))

local selectedAnimal = animalList[1] or (string.char(78,111,110,101))
local selectedTraits = {}
local selectedMutation = (string.char(78,111,110,101))
local traitToggles = {}

SpawnerSection:CreateDropdown((string.char(83,101,108,101,99,116,32,66,114,97,105,110,114,111,116)), animalList, animalList[1], function(choice)
    selectedAnimal = choice
end)

SpawnerSection:CreateDropdown((string.char(83,101,108,101,99,116,32,77,117,116,97,116,105,111,110)), mutationList, (string.char(78,111,110,101)), function(choice)
    selectedMutation = choice
end)

local traitSelectionSection = SpawnerTab:CreateSection((string.char(84,114,97,105,116,32,83,101,108,101,99,116,105,111,110,32,40,73,110,102,105,110,105,116,101,41)))

for _, traitName in ipairs(traitList) do
    local toggle = traitSelectionSection:CreateToggle(traitName, false, function(state)
        if state then
            if not table.find(selectedTraits, traitName) then
                table.insert(selectedTraits, traitName)
            end
        else
            local index = table.find(selectedTraits, traitName)
            if index then
                table.remove(selectedTraits, index)
            end
        end
    end)
    traitToggles[traitName] = toggle
end

local ActionsSection = SpawnerTab:CreateSection((string.char(65,99,116,105,111,110,115)))

ActionsSection:CreateButton((string.char(83,112,97,119,110,32,66,114,97,105,110,114,111,116)), function()
    if not selectedAnimal or selectedAnimal == (string.char(78,111,110,101)) or selectedAnimal == (string.char()) then
        return
    end

    local traitsToApply = {}
    for _, trait in ipairs(selectedTraits) do
        table.insert(traitsToApply, trait)
    end
    
    local mutationToApply = (selectedMutation == (string.char(78,111,110,101))) and nil or selectedMutation

    local success, result = spawnAnimal(selectedAnimal, traitsToApply, mutationToApply)
    if not success then
        warn((string.char(70,97,105,108,101,100,32,116,111,32,115,112,97,119,110,58,32)) .. tostring(result))
    end
end)

ActionsSection:CreateButton((string.char(67,108,101,97,114,32,65,108,108,32,84,114,97,105,116,115)), function()
    selectedTraits = {}
    for traitName, toggle in pairs(traitToggles) do
        if toggle and toggle.Set then
            toggle:Set(false)
        end
    end
end)

local function createNotification(title, description, duration, iconId)
    duration = duration or 5
    iconId = iconId or (string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,48,55,52,55,51,53,57,54,52,54))  -- Default Discord-like icon, change if needed
    
    local screenGui = Instance.new((string.char(83,99,114,101,101,110,71,117,105)))
    screenGui.Name = (string.char(67,117,115,116,111,109,78,111,116,105,102,105,99,97,116,105,111,110,71,117,105))
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService((string.char(67,111,114,101,71,117,105)))
    
    local frame = Instance.new((string.char(70,114,97,109,101)))
    frame.Size = UDim2.new(0, 300, 0, 80)
    frame.Position = UDim2.new(1, -320, 0, 20)  -- Start off-screen
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0.1
    frame.Parent = screenGui
    
    local corner = Instance.new((string.char(85,73,67,111,114,110,101,114)))
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local stroke = Instance.new((string.char(85,73,83,116,114,111,107,101)))
    stroke.Color = Color3.fromRGB(80, 80, 80)
    stroke.Thickness = 1
    stroke.Parent = frame
    
    local icon = Instance.new((string.char(73,109,97,103,101,76,97,98,101,108)))
    icon.Size = UDim2.new(0, 50, 0, 50)
    icon.Position = UDim2.new(0, 15, 0.5, -25)
    icon.BackgroundTransparency = 1
    icon.Image = iconId
    icon.Parent = frame
    
    local titleLabel = Instance.new((string.char(84,101,120,116,76,97,98,101,108)))
    titleLabel.Size = UDim2.new(1, -80, 0, 25)
    titleLabel.Position = UDim2.new(0, 75, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame
    
    local descLabel = Instance.new((string.char(84,101,120,116,76,97,98,101,108)))
    descLabel.Size = UDim2.new(1, -80, 0, 30)
    descLabel.Position = UDim2.new(0, 75, 0, 35)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = description
    descLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 14
    descLabel.TextWrapped = true
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = frame
    
    -- Animate in
    frame:TweenPosition(UDim2.new(1, -320, 0, 20), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    
    -- Auto destroy after duration
    task.delay(duration, function()
        frame:TweenPosition(UDim2.new(1, 20, 0, 20), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.5, true, function()
            screenGui:Destroy()
        end)
    end)
end

local DiscordTab = Window:CreateTab((string.char(68,73,83,67,79,82,68)), (string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,48,55,52,55,51,53,57,54,52,54)))

local DiscordSection = DiscordTab:CreateSection((string.char(67,111,109,109,117,110,105,116,121,32,72,117,98)))

local discordInvite = (string.char(104,116,116,112,115,58,47,47,100,105,115,99,111,114,100,46,103,103,47,83,110,88,81,67,89,122,71,106,120))  -- Popular active server for Steal a Brainrot (trading, giveaways, updates)

DiscordSection:CreateButton((string.char(67,111,112,121,32,68,105,115,99,111,114,100,32,73,110,118,105,116,101)), function()
    setclipboard(discordInvite)
    createNotification((string.char(68,105,115,99,111,114,100,32,73,110,118,105,116,101,32,67,111,112,105,101,100,33)), "Join the best scripts discord server!\nInstant Steal, de-sync, dupe & more.(string.char(44,32,54,44,32))rbxassetid://10747359646(string.char(41,13,10,101,110,100,41,13,10,13,10,68,105,115,99,111,114,100,83,101,99,116,105,111,110,58,67,114,101,97,116,101,76,97,98,101,108,40))Join the best scripts discord server!\nInstant Steal, de-sync, dupe & more.")