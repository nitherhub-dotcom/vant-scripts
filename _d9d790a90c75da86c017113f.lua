-- Protection by Vants
local _KEY=""
local _ok,_raw=pcall(function()
  return game:HttpGet("https://raw.githubusercontent.com/nitherhub-dotcom/vant-scripts/main/_s3951d95d949101c02189.txt")
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

-- ============================================================
-- AKAZA DUELS — UI refeita no estilo Fayk
-- ============================================================
local CoreGui    = game:GetService("CoreGui")
local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS        = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local player     = Players.LocalPlayer

-- cleanup
if CoreGui:FindFirstChild("AkazaUI") then CoreGui.AkazaUI:Destroy() end
if CoreGui:FindFirstChild("AkazaConfig") then CoreGui.AkazaConfig:Destroy() end

-- ============================================================
-- CFG
-- ============================================================
local CFG_FILE = "akaza_cfg.json"
local DEFAULT_CFG = {
    spinSpeed      = 10,
    boosterNormal  = 57.5,
    boosterSteal   = 29,
    keybinds       = {},
    spdHead        = false,
}

local function loadCfg()
    local ok, r = pcall(function()
        if isfile and isfile(CFG_FILE) then
            return HttpService:JSONDecode(readfile(CFG_FILE))
        end
    end)
    if ok and r then
        for k, v in pairs(DEFAULT_CFG) do
            if r[k] == nil then r[k] = v end
        end
        return r
    end
    return HttpService:JSONDecode(HttpService:JSONEncode(DEFAULT_CFG))
end

local function saveCfg(cfg)
    pcall(function()
        if writefile then writefile(CFG_FILE, HttpService:JSONEncode(cfg)) end
    end)
end

local CFG = loadCfg()

-- ============================================================
-- UI HELPERS
-- ============================================================
local function C(r,g,b) return Color3.fromRGB(r,g,b) end

local BG    = C(12,12,16)
local BG2   = C(17,17,22)
local ROW   = C(19,19,25)
local HOVER = C(24,24,32)
local TXT   = C(228,228,235)
local MUTED = C(95,95,115)
local STROKE_C = C(50,50,62)

local function tw(obj, t, props)
    TweenService:Create(obj, TweenInfo.new(t, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props):Play()
end

local function mkCorner(p, r)
    local c = Instance.new("UICorner", p)
    c.CornerRadius = UDim.new(0, r or 12)
    return c
end

local function mkStroke(p, col, thick, transp)
    local s = Instance.new("UIStroke", p)
    s.Color = col or STROKE_C
    s.Thickness = thick or 1.2
    s.Transparency = transp or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return s
end

local function mkGlow(p)
    local s = mkStroke(p, C(100,100,150), 1.2, 0.55)
    local g = Instance.new("UIGradient", s)
    g.Rotation = 0
    g.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0,   1),
        NumberSequenceKeypoint.new(0.4, 0.15),
        NumberSequenceKeypoint.new(0.6, 0.15),
        NumberSequenceKeypoint.new(1,   1),
    })
    RunService.Heartbeat:Connect(function(dt)
        g.Rotation = (g.Rotation + 85*dt) % 360
    end)
    return s, g
end

-- ============================================================
-- SCREEN GUI
-- ============================================================
local sg = Instance.new("ScreenGui")
sg.Name = "AkazaUI"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = CoreGui

-- ============================================================
-- TOP HUD BAR
-- ============================================================
local hudBar = Instance.new("Frame", sg)
hudBar.Size = UDim2.new(0, 380, 0, 56)
hudBar.Position = UDim2.new(0.5, -190, 0, 6)
hudBar.BackgroundColor3 = BG2
hudBar.BorderSizePixel = 0
mkCorner(hudBar, 14)
mkStroke(hudBar, STROKE_C, 1, 0)
mkGlow(hudBar)

-- avatar thumbnail
local avatarImg = Instance.new("ImageLabel", hudBar)
avatarImg.Size = UDim2.new(0, 40, 0, 40)
avatarImg.Position = UDim2.new(0, 8, 0.5, -20)
avatarImg.BackgroundColor3 = ROW
avatarImg.BorderSizePixel = 0
mkCorner(avatarImg, 10)
mkStroke(avatarImg, STROKE_C, 1, 0.3)
avatarImg.Image = ""
task.spawn(function()
    local ok, img = pcall(function()
        return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
    end)
    if ok then avatarImg.Image = img end
end)

-- title
local hudTitle = Instance.new("TextLabel", hudBar)
hudTitle.Size = UDim2.new(0, 95, 0, 20)
hudTitle.Position = UDim2.new(0, 56, 0, 6)
hudTitle.BackgroundTransparency = 1
hudTitle.Text = "AKAZA DUELS"
hudTitle.TextColor3 = TXT
hudTitle.Font = Enum.Font.GothamBlack
hudTitle.TextSize = 12
hudTitle.TextXAlignment = Enum.TextXAlignment.Left
hudTitle.ClipsDescendants = false

local hudSub = Instance.new("TextLabel", hudBar)
hudSub.Size = UDim2.new(0, 95, 0, 16)
hudSub.Position = UDim2.new(0, 56, 0, 28)
hudSub.BackgroundTransparency = 1
hudSub.Text = player.Name
hudSub.TextColor3 = MUTED
hudSub.Font = Enum.Font.Gotham
hudSub.TextSize = 10
hudSub.TextXAlignment = Enum.TextXAlignment.Left

-- divider
local hudDiv = Instance.new("Frame", hudBar)
hudDiv.Size = UDim2.new(0, 1, 1, -16)
hudDiv.Position = UDim2.new(0, 158, 0, 8)
hudDiv.BackgroundColor3 = STROKE_C
hudDiv.BorderSizePixel = 0

-- stat labels factory
local function mkStat(xOffset, topText, valueText)
    local col = Instance.new("Frame", hudBar)
    col.Size = UDim2.new(0, 62, 1, 0)
    col.Position = UDim2.new(0, xOffset, 0, 0)
    col.BackgroundTransparency = 1

    local top = Instance.new("TextLabel", col)
    top.Size = UDim2.new(1, 0, 0, 18)
    top.Position = UDim2.new(0, 0, 0, 8)
    top.BackgroundTransparency = 1
    top.Text = topText
    top.TextColor3 = MUTED
    top.Font = Enum.Font.GothamBold
    top.TextSize = 9
    top.TextXAlignment = Enum.TextXAlignment.Center

    local val = Instance.new("TextLabel", col)
    val.Size = UDim2.new(1, 0, 0, 20)
    val.Position = UDim2.new(0, 0, 0, 26)
    val.BackgroundTransparency = 1
    val.Text = valueText
    val.TextColor3 = TXT
    val.Font = Enum.Font.GothamBlack
    val.TextSize = 13
    val.TextXAlignment = Enum.TextXAlignment.Center

    return val
end

-- FPS at 166, PING at 230, SPD at 296 (after wider divider gap)
local fpsVal  = mkStat(166, "FPS",  "—")
local pingVal = mkStat(232, "PING", "—")
local spdVal  = mkStat(298, "SPD",  "—")

-- gear icon
local gearBtn = Instance.new("TextButton", hudBar)
gearBtn.Size = UDim2.new(0, 28, 0, 28)
gearBtn.Position = UDim2.new(1, -36, 0.5, -14)
gearBtn.BackgroundColor3 = ROW
gearBtn.Text = "⚙"
gearBtn.TextColor3 = MUTED
gearBtn.Font = Enum.Font.GothamBold
gearBtn.TextSize = 14
gearBtn.AutoButtonColor = false
gearBtn.ZIndex = 5
mkCorner(gearBtn, 8)
mkStroke(gearBtn, STROKE_C, 1, 0.2)
gearBtn.MouseEnter:Connect(function() tw(gearBtn, 0.12, {TextColor3 = TXT}) end)
gearBtn.MouseLeave:Connect(function() tw(gearBtn, 0.12, {TextColor3 = MUTED}) end)

-- ============================================================
-- BUTTONS GRID  (right side)
-- ============================================================
local BSIZE  = 56
local BGAP   = 7
local COLS   = 3

local gridHolder = Instance.new("Frame", sg)
gridHolder.BackgroundTransparency = 1
gridHolder.Size = UDim2.new(0, BSIZE*COLS + BGAP*(COLS-1), 0, 1)
gridHolder.Position = UDim2.new(1, -(BSIZE*COLS + BGAP*(COLS-1)) - 10, 0, 70)
gridHolder.AutomaticSize = Enum.AutomaticSize.Y

local gridLayout = Instance.new("UIGridLayout", gridHolder)
gridLayout.CellSize = UDim2.new(0, BSIZE, 0, BSIZE)
gridLayout.CellPadding = UDim2.new(0, BGAP, 0, BGAP)
gridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
gridLayout.VerticalAlignment = Enum.VerticalAlignment.Top
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder

local bStates = {}

local function mkButton(label)
    bStates[label] = false

    local border = Instance.new("Frame", gridHolder)
    border.BackgroundColor3 = ROW
    border.BorderSizePixel = 0
    mkCorner(border, 12)
    mkStroke(border, STROKE_C, 1, 0)
    local _, glowG = mkGlow(border)

    local btn = Instance.new("TextButton", border)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = label
    btn.TextColor3 = MUTED
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 9
    btn.AutoButtonColor = false
    btn.TextWrapped = true

    local kbLabel = Instance.new("TextLabel", border)
    kbLabel.Size = UDim2.new(1, 0, 0, 12)
    kbLabel.Position = UDim2.new(0, 0, 1, -13)
    kbLabel.BackgroundTransparency = 1
    kbLabel.Text = CFG.keybinds[label] or ""
    kbLabel.TextColor3 = C(70,70,90)
    kbLabel.Font = Enum.Font.Gotham
    kbLabel.TextSize = 8

    local function refresh()
        if bStates[label] then
            tw(border, 0.18, {BackgroundColor3 = C(24,24,34)})
            tw(btn,    0.18, {TextColor3 = TXT})
        else
            tw(border, 0.18, {BackgroundColor3 = ROW})
            tw(btn,    0.18, {TextColor3 = MUTED})
        end
    end

    btn.MouseEnter:Connect(function() tw(border, 0.1, {BackgroundColor3 = HOVER}) end)
    btn.MouseLeave:Connect(function() refresh() end)

    return btn, kbLabel, refresh
end

-- ============================================================
-- ALL SYSTEMS
-- ============================================================

-- INF JUMP
local infJumpEnabled = false
local jumpForce = 50
local clampFallSpeed = 80
local infJumpHB, infJumpReq

local function startInfJump()
    infJumpEnabled = true
    infJumpHB = RunService.Heartbeat:Connect(function()
        if not infJumpEnabled then return end
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp and hrp.Velocity.Y < -clampFallSpeed then
            hrp.Velocity = Vector3.new(hrp.Velocity.X, -clampFallSpeed, hrp.Velocity.Z)
        end
    end)
    infJumpReq = UIS.JumpRequest:Connect(function()
        if not infJumpEnabled then return end
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Velocity = Vector3.new(hrp.Velocity.X, jumpForce, hrp.Velocity.Z) end
    end)
end
local function stopInfJump()
    infJumpEnabled = false
    if infJumpHB  then infJumpHB:Disconnect()  infJumpHB  = nil end
    if infJumpReq then infJumpReq:Disconnect() infJumpReq = nil end
end

-- SPIN BOT
local spinBotActive = false
local spinForce, spinOrigAutoRotate

local function startSpinBot()
    local char = player.Character; if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not (hum and hrp) then return end
    spinOrigAutoRotate = hum.AutoRotate
    hum.AutoRotate = false
    local att = hrp:FindFirstChild("RootAttachment") or Instance.new("Attachment", hrp)
    att.Name = "RootAttachment"
    spinForce = Instance.new("AngularVelocity", hrp)
    spinForce.Name = "SpinForce"
    spinForce.Attachment0 = att
    spinForce.AngularVelocity = Vector3.new(0, CFG.spinSpeed, 0)
    spinForce.MaxTorque = math.huge
    spinForce.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
end
local function stopSpinBot()
    if spinForce then spinForce:Destroy(); spinForce = nil end
    local hum = player.Character and player.Character:FindFirstChild("Humanoid")
    if hum and spinOrigAutoRotate ~= nil then hum.AutoRotate = spinOrigAutoRotate end
end

player.CharacterAdded:Connect(function(char)
    if spinBotActive then
        task.wait(1)
        local hum = char:WaitForChild("Humanoid")
        local hrp = char:WaitForChild("HumanoidRootPart")
        hum.AutoRotate = false
        local att = hrp:FindFirstChild("RootAttachment") or Instance.new("Attachment", hrp)
        att.Name = "RootAttachment"
        spinForce = Instance.new("AngularVelocity", hrp)
        spinForce.Name = "SpinForce"
        spinForce.Attachment0 = att
        spinForce.AngularVelocity = Vector3.new(0, CFG.spinSpeed, 0)
        spinForce.MaxTorque = math.huge
        spinForce.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
    end
end)

-- BOOSTER
local boosterActive = false
local boosterConn

local function startBooster()
    if boosterConn then boosterConn:Disconnect() end
    local char = player.Character; if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not (hrp and hum) then return end
    hum.JumpHeight = 60
    boosterConn = RunService.Heartbeat:Connect(function()
        if not boosterActive then return end
        local c = player.Character; if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart")
        local hu = c:FindFirstChildOfClass("Humanoid")
        if not (h and hu) then return end
        if hu.MoveDirection.Magnitude > 0 then
            local spd = hu.WalkSpeed < 25 and CFG.boosterSteal or CFG.boosterNormal
            h.AssemblyLinearVelocity = Vector3.new(hu.MoveDirection.X*spd, h.AssemblyLinearVelocity.Y, hu.MoveDirection.Z*spd)
        end
    end)
end
local function stopBooster()
    if boosterConn then boosterConn:Disconnect(); boosterConn = nil end
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpHeight = 7.2 end
end

player.CharacterAdded:Connect(function(newChar)
    if boosterActive then
        local hrp = newChar:WaitForChild("HumanoidRootPart")
        local hum = newChar:WaitForChild("Humanoid")
        hum.JumpHeight = 60
        if boosterConn then boosterConn:Disconnect() end
        boosterConn = RunService.Heartbeat:Connect(function()
            if not boosterActive then return end
            if hum.MoveDirection.Magnitude > 0 then
                local spd = hum.WalkSpeed < 25 and CFG.boosterSteal or CFG.boosterNormal
                hrp.AssemblyLinearVelocity = Vector3.new(hum.MoveDirection.X*spd, hrp.AssemblyLinearVelocity.Y, hum.MoveDirection.Z*spd)
            end
        end)
    end
end)

-- AUTO BAT
local autoBatActive = false
local autoBatConn

local function startAutoBat()
    if autoBatConn then return end
    autoBatConn = RunService.RenderStepped:Connect(function()
        if not autoBatActive then return end
        local char = player.Character; if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
        local bat = player.Backpack:FindFirstChild("Bat")
        if bat then hum:EquipTool(bat) end
        local eq = char:FindFirstChild("Bat")
        if eq then eq:Activate() end
    end)
end
local function stopAutoBat()
    if autoBatConn then autoBatConn:Disconnect(); autoBatConn = nil end
end

-- ANTI RAGDOLL
local antiRagActive = false
local antiRagConns = {}

local function startAntiRagdoll()
    if #antiRagConns > 0 then return end
    local char = player.Character or player.CharacterAdded:Wait()
    local hum  = char:WaitForChild("Humanoid")
    local hrp  = char:WaitForChild("HumanoidRootPart")
    local anim = hum:WaitForChild("Animator")
    local lastVel = Vector3.zero

    local function clean(c)
        for _, d in pairs(c:GetDescendants()) do
            if d:IsA("BallSocketConstraint") or d:IsA("NoCollisionConstraint") or d:IsA("HingeConstraint") then
                pcall(function() d:Destroy() end)
            elseif d:IsA("Attachment") and (d.Name=="A" or d.Name=="B") then
                pcall(function() d:Destroy() end)
            elseif d:IsA("BodyVelocity") or d:IsA("BodyPosition") or d:IsA("BodyGyro") then
                pcall(function() d:Destroy() end)
            end
        end
        for _, d in pairs(c:GetDescendants()) do
            if d:IsA("Motor6D") then d.Enabled = true end
        end
    end

    local function stopAnims()
        for _, t in pairs(anim:GetPlayingAnimationTracks()) do
            if t.Animation then
                local n = t.Animation.Name:lower()
                if n:find("rag") or n:find("fall") or n:find("hurt") or n:find("down") or n:find("knock") then
                    t:Stop(0)
                end
            end
        end
    end

    local function enableControls()
        pcall(function()
            local pm = player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
            require(pm):GetControls():Enable()
        end)
    end

    local blocked = {
        [Enum.HumanoidStateType.Physics]=true,[Enum.HumanoidStateType.Ragdoll]=true,
        [Enum.HumanoidStateType.FallingDown]=true,[Enum.HumanoidStateType.GettingUp]=true
    }
    local function shouldApply() return not blocked[hum:GetState()] end

    clean(char); stopAnims(); enableControls()

    table.insert(antiRagConns, hum.StateChanged:Connect(function()
        if not antiRagActive then return end
        if shouldApply() then
            hum:ChangeState(Enum.HumanoidStateType.Running)
            clean(char); stopAnims()
            workspace.CurrentCamera.CameraSubject = hum
            enableControls()
        end
    end))
    table.insert(antiRagConns, char.DescendantAdded:Connect(function()
        if antiRagActive and shouldApply() then clean(char); stopAnims() end
    end))
    table.insert(antiRagConns, RunService.Heartbeat:Connect(function()
        if not antiRagActive then return end
        if shouldApply() then
            clean(char); stopAnims()
            local cv = hrp.AssemblyLinearVelocity
            local ch = Vector3.new(cv.X,0,cv.Z)
            local lh = Vector3.new(lastVel.X,0,lastVel.Z)
            if (ch-lh).Magnitude > 40 and ch.Magnitude > 25 then
                hrp.AssemblyLinearVelocity = Vector3.new(cv.X/ch.Magnitude*15, cv.Y, cv.Z/ch.Magnitude*15)
            end
            lastVel = cv
        end
    end))
    table.insert(antiRagConns, player.CharacterAdded:Connect(function(nc)
        char=nc; hum=nc:WaitForChild("Humanoid"); hrp=nc:WaitForChild("HumanoidRootPart")
        anim=hum:WaitForChild("Animator"); lastVel=Vector3.zero
        enableControls(); clean(char); stopAnims()
    end))
end
local function stopAntiRagdoll()
    for _, c in pairs(antiRagConns) do if c then c:Disconnect() end end
    antiRagConns = {}
end

-- ============================================================
-- FLOAT — teleporta pra cima e trava Y
-- ============================================================
local floatActive = false
local floatConn

local function startFloat()
    if floatConn then floatConn:Disconnect(); floatConn = nil end
    local char = player.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y + 8, hrp.Position.Z)
            hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, 0, hrp.AssemblyLinearVelocity.Z)
        end
    end
    floatConn = RunService.Heartbeat:Connect(function()
        if not floatActive then
            if floatConn then floatConn:Disconnect(); floatConn = nil end
            return
        end
        local c = player.Character; if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart"); if not h then return end
        h.AssemblyLinearVelocity = Vector3.new(h.AssemblyLinearVelocity.X, 0, h.AssemblyLinearVelocity.Z)
    end)
end
local function stopFloat()
    if floatConn then floatConn:Disconnect(); floatConn = nil end
end

-- X-RAY
local xrayActive = false
local xrayOrigTrans = {}
local xrayPlotConns = {}
local xrayConn

local function applyXray(plot)
    if xrayOrigTrans[plot] then return end
    xrayOrigTrans[plot] = {}
    for _, p in ipairs(plot:GetDescendants()) do
        if p:IsA("BasePart") and p.Transparency < 0.6 then
            xrayOrigTrans[plot][p] = p.Transparency
            p.Transparency = 0.68
        end
    end
    xrayPlotConns[plot] = plot.DescendantAdded:Connect(function(d)
        if d:IsA("BasePart") and d.Transparency < 0.6 then
            xrayOrigTrans[plot][d] = d.Transparency
            d.Transparency = 0.68
        end
    end)
end

local function toggleXRay(on)
    local plots = workspace:FindFirstChild("Plots"); if not plots then return end
    if not on then
        for _, c in pairs(xrayPlotConns) do c:Disconnect() end
        xrayPlotConns = {}
        if xrayConn then xrayConn:Disconnect(); xrayConn = nil end
        for _, parts in pairs(xrayOrigTrans) do
            for p, t in pairs(parts) do if p and p.Parent then p.Transparency = t end end
        end
        xrayOrigTrans = {}
        return
    end
    for _, plot in ipairs(plots:GetChildren()) do applyXray(plot) end
    xrayConn = plots.ChildAdded:Connect(function(np) task.wait(0.2); applyXray(np) end)
end

-- AIMBOT
local batAimbotActive = false
local batAimbotConn
local AimbotRadius = 100
local BatAimbotSpeed = 55

local SlapList = {"Bat","Slap","Iron Slap","Gold Slap","Diamond Slap","Emerald Slap","Ruby Slap","Dark Matter Slap","Flame Slap","Nuclear Slap","Galaxy Slap","Glitched Slap"}

local function findBatTool()
    local char = player.Character
    local bp   = player:FindFirstChildOfClass("Backpack")
    if char then
        for _, ch in ipairs(char:GetChildren()) do
            if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end
        end
    end
    if bp then
        for _, ch in ipairs(bp:GetChildren()) do
            if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end
        end
    end
    for _, nm in ipairs(SlapList) do
        local t = char and char:FindFirstChild(nm) or bp and bp:FindFirstChild(nm)
        if t then return t end
    end
end

local function findNearestEnemy(myHRP)
    local nearest, nearestDist, nearestTorso = nil, math.huge, nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local eh  = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if eh and hum and hum.Health > 0 then
                local d = (eh.Position - myHRP.Position).Magnitude
                if d < nearestDist and d <= AimbotRadius then
                    nearestDist=d; nearest=eh
                    nearestTorso = p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso") or eh
                end
            end
        end
    end
    return nearest, nearestDist, nearestTorso
end

local function startBatAimbot()
    if batAimbotConn then return end
    batAimbotConn = RunService.Heartbeat:Connect(function()
        if not batAimbotActive then return end
        local char = player.Character; if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not (hrp and hum) then return end
        local bat = findBatTool()
        if bat and bat.Parent ~= char then hum:EquipTool(bat) end
        local target, _, torso = findNearestEnemy(hrp)
        if target and torso then
            local pred = torso.Position + torso.AssemblyLinearVelocity * 0.13
            local dir  = pred - hrp.Position
            if dir.Magnitude > 1.5 then
                hrp.AssemblyLinearVelocity = dir.Unit * BatAimbotSpeed
            else
                hrp.AssemblyLinearVelocity = target.AssemblyLinearVelocity
            end
        end
    end)
end
local function stopBatAimbot()
    if batAimbotConn then batAimbotConn:Disconnect(); batAimbotConn = nil end
end

-- AUTO GRAB
local autoGrabEnabled = false
local grabHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
local grabHum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
player.CharacterAdded:Connect(function(c)
    grabHRP = c:WaitForChild("HumanoidRootPart")
    grabHum = c:WaitForChild("Humanoid")
end)

local function getGrabPos(prompt)
    local p = prompt.Parent
    if p:IsA("BasePart") then return p.Position end
    if p:IsA("Model") then local pp = p.PrimaryPart or p:FindFirstChildWhichIsA("BasePart"); return pp and pp.Position end
    if p:IsA("Attachment") then return p.WorldPosition end
    local part = p:FindFirstChildWhichIsA("BasePart", true); return part and part.Position
end

local function findNearestSteal()
    if not grabHRP then return end
    local plots = workspace:FindFirstChild("Plots"); if not plots then return end
    local nearest, nearDist = nil, math.huge
    for _, plot in ipairs(plots:GetChildren()) do
        for _, obj in ipairs(plot:GetDescendants()) do
            if obj:IsA("ProximityPrompt") and obj.Enabled and obj.ActionText=="Steal" then
                local pos = getGrabPos(obj)
                if pos then
                    local d = (grabHRP.Position - pos).Magnitude
                    if d <= 12 and d < nearDist then nearest=obj; nearDist=d end
                end
            end
        end
    end
    return nearest
end

task.spawn(function()
    while true do
        if autoGrabEnabled and grabHum and grabHum.Health > 0 then
            local p = findNearestSteal()
            if p then
                task.spawn(function()
                    pcall(function()
                        fireproximityprompt(p, 10000)
                        p:InputHoldBegin(); task.wait(0.04); p:InputHoldEnd()
                    end)
                end)
            end
        end
        task.wait(0.3)
    end
end)

-- AUTO LEFT / RIGHT
local LEFT_HOUSE  = Vector3.new(-476.48, -6.28, 92.73)
local LEFT_PODIUM = Vector3.new(-483.12, -4.95, 94.80)
local RIGHT_HOUSE  = Vector3.new(-476.16, -6.52, 25.62)
local RIGHT_PODIUM = Vector3.new(-483.04, -5.09, 23.14)
local leftActive  = false
local rightActive = false

local function goTo(target, speed, cond)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    while cond() and (hrp.Position - target).Magnitude > 0.6 do
        local dir = (target - hrp.Position).Unit
        hrp.AssemblyLinearVelocity = Vector3.new(dir.X*speed, hrp.AssemblyLinearVelocity.Y, dir.Z*speed)
        task.wait()
    end
end

local function startAutoLeft()
    if leftActive then return end
    if rightActive then rightActive = false; bStates["auto right"] = false end
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    leftActive = true
    local startPos = hrp.Position
    task.spawn(function()
        goTo(LEFT_HOUSE,  58,   function() return leftActive end)
        goTo(LEFT_PODIUM, 58,   function() return leftActive end)
        if leftActive then task.wait(0.16) end
        goTo(LEFT_HOUSE,  29.5, function() return leftActive end)
        goTo(startPos,    29.5, function() return leftActive end)
        local h = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if h then h.AssemblyLinearVelocity = Vector3.zero end
        leftActive = false; bStates["auto left"] = false
    end)
end
local function stopAutoLeft()
    leftActive = false
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.AssemblyLinearVelocity = Vector3.zero end
end

local function startAutoRight()
    if rightActive then return end
    if leftActive then stopAutoLeft(); bStates["auto left"] = false end
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    rightActive = true
    local startPos = hrp.Position
    task.spawn(function()
        goTo(RIGHT_HOUSE,  58,   function() return rightActive end)
        goTo(RIGHT_PODIUM, 58,   function() return rightActive end)
        if rightActive then task.wait(0.16) end
        goTo(RIGHT_HOUSE,  29.5, function() return rightActive end)
        goTo(startPos,     29.5, function() return rightActive end)
        local h = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if h then h.AssemblyLinearVelocity = Vector3.zero end
        rightActive = false; bStates["auto right"] = false
    end)
end
local function stopAutoRight()
    rightActive = false
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.AssemblyLinearVelocity = Vector3.zero end
end

-- SPD HEAD (billboard)
local spdHeadBB = nil

local function buildSpdHead()
    if spdHeadBB then spdHeadBB:Destroy(); spdHeadBB = nil end
    local char = player.Character; if not char then return end
    local head = char:FindFirstChild("Head"); if not head then return end
    local bb = Instance.new("BillboardGui")
    bb.Name = "AkazaSpdHead"
    bb.Size = UDim2.new(0, 80, 0, 22)
    bb.StudsOffset = Vector3.new(0, 2.8, 0)
    bb.AlwaysOnTop = false
    bb.ResetOnSpawn = false
    bb.Adornee = head
    bb.Parent = CoreGui
    local lbl = Instance.new("TextLabel", bb)
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 16
    lbl.Text = "0 sp"
    lbl.TextStrokeTransparency = 0.25
    lbl.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    spdHeadBB = bb
    return lbl
end

local spdHeadLbl = nil
if CFG.spdHead then spdHeadLbl = buildSpdHead() end

player.CharacterAdded:Connect(function()
    task.wait(0.3)
    if CFG.spdHead then spdHeadLbl = buildSpdHead() end
end)

-- ============================================================
-- BUTTON LIST
-- ============================================================
local buttonDefs = {
    "auto left","inf jump","auto right",
    "auto jump","spin bot","booster",
    "x-ray","auto bat","aimbot",
    "ant ragdoll","float","auto grab"
}

local btnRefs = {}

for _, name in ipairs(buttonDefs) do
    local btn, kbLbl, refresh = mkButton(name)
    btnRefs[name] = { btn=btn, kbLbl=kbLbl, refresh=refresh }
end

-- ============================================================
-- ACTION FUNCTIONS — separadas para keybind poder chamar direto
-- ============================================================
local actionFuncs = {}

actionFuncs["auto left"]   = function()
    if bStates["auto left"] then startAutoLeft() else stopAutoLeft() end
end
actionFuncs["inf jump"]    = function()
    if bStates["inf jump"] then startInfJump() else stopInfJump() end
end
actionFuncs["auto right"]  = function()
    if bStates["auto right"] then startAutoRight() else stopAutoRight() end
end
actionFuncs["auto jump"]   = function() end -- placeholder
actionFuncs["spin bot"]    = function()
    spinBotActive = bStates["spin bot"]
    if bStates["spin bot"] then startSpinBot() else stopSpinBot() end
end
actionFuncs["booster"]     = function()
    boosterActive = bStates["booster"]
    if bStates["booster"] then startBooster() else stopBooster() end
end
actionFuncs["x-ray"]       = function()
    xrayActive = bStates["x-ray"]
    toggleXRay(bStates["x-ray"])
end
actionFuncs["auto bat"]    = function()
    autoBatActive = bStates["auto bat"]
    if bStates["auto bat"] then startAutoBat() else stopAutoBat() end
end
actionFuncs["aimbot"]      = function()
    batAimbotActive = bStates["aimbot"]
    if bStates["aimbot"] then startBatAimbot() else stopBatAimbot() end
end
actionFuncs["ant ragdoll"] = function()
    antiRagActive = bStates["ant ragdoll"]
    if bStates["ant ragdoll"] then startAntiRagdoll() else stopAntiRagdoll() end
end
actionFuncs["float"]       = function()
    floatActive = bStates["float"]
    if bStates["float"] then startFloat() else stopFloat() end
end
actionFuncs["auto grab"]   = function()
    autoGrabEnabled = bStates["auto grab"]
end

-- Wire button clicks
for _, name in ipairs(buttonDefs) do
    local ref = btnRefs[name]
    ref.btn.MouseButton1Click:Connect(function()
        bStates[name] = not bStates[name]
        ref.refresh()
        if actionFuncs[name] then actionFuncs[name]() end
    end)
end

-- ============================================================
-- KEYBIND SYSTEM — corrigido para chamar actionFuncs diretamente
-- ============================================================
local listeningFor = nil

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

    -- atribuindo keybind
    if listeningFor then
        local key = input.KeyCode.Name
        if key == "Escape" then
            CFG.keybinds[listeningFor] = nil
        else
            CFG.keybinds[listeningFor] = key
        end
        local ref = btnRefs[listeningFor]
        if ref then ref.kbLbl.Text = CFG.keybinds[listeningFor] or "" end
        listeningFor = nil
        return
    end

    -- disparar keybind
    for name, key in pairs(CFG.keybinds) do
        if key and input.KeyCode.Name == key then
            bStates[name] = not bStates[name]
            local ref = btnRefs[name]
            if ref then ref.refresh() end
            if actionFuncs[name] then actionFuncs[name]() end
        end
    end
end)

-- ============================================================
-- CONFIG PANEL
-- ============================================================
local cfgPanel = nil
local cfgOpen  = false

local function buildCfgPanel()
    if cfgPanel then cfgPanel:Destroy(); cfgPanel = nil end

    local csg = Instance.new("ScreenGui", CoreGui)
    csg.Name = "AkazaConfig"
    csg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    csg.ResetOnSpawn = false
    cfgPanel = csg

    local W = 260

    local panel = Instance.new("Frame", csg)
    panel.Size = UDim2.new(0, W, 0, 10)
    panel.Position = UDim2.new(0.5, -W/2, 0.5, -200)
    panel.BackgroundColor3 = BG
    panel.BorderSizePixel = 0
    panel.Active = true
    panel.ZIndex = 10
    mkCorner(panel, 16)
    mkStroke(panel, STROKE_C, 1, 0)
    mkGlow(panel)

    local ph = Instance.new("Frame", panel)
    ph.Size = UDim2.new(1,0,0,54)
    ph.BackgroundColor3 = BG2
    ph.BorderSizePixel = 0
    ph.ZIndex = 10
    mkCorner(ph, 16)
    local phFix = Instance.new("Frame", ph)
    phFix.Size = UDim2.new(1,0,0,18); phFix.Position = UDim2.new(0,0,1,-18)
    phFix.BackgroundColor3 = BG2; phFix.BorderSizePixel = 0

    local phTitle = Instance.new("TextLabel", ph)
    phTitle.Size = UDim2.new(1,-42,0,26); phTitle.Position = UDim2.new(0,14,0,8)
    phTitle.BackgroundTransparency = 1; phTitle.Text = "Akaza Config"
    phTitle.TextColor3 = TXT; phTitle.Font = Enum.Font.GothamBlack
    phTitle.TextSize = 14; phTitle.TextXAlignment = Enum.TextXAlignment.Left; phTitle.ZIndex = 11

    local phSub = Instance.new("TextLabel", ph)
    phSub.Size = UDim2.new(1,-14,0,14); phSub.Position = UDim2.new(0,14,0,34)
    phSub.BackgroundTransparency = 1; phSub.Text = "Settings & Keybinds"
    phSub.TextColor3 = MUTED; phSub.Font = Enum.Font.Gotham
    phSub.TextSize = 10; phSub.TextXAlignment = Enum.TextXAlignment.Left; phSub.ZIndex = 11

    local closeB = Instance.new("TextButton", ph)
    closeB.Size = UDim2.new(0,26,0,26); closeB.Position = UDim2.new(1,-36,0,10)
    closeB.BackgroundColor3 = ROW; closeB.Text = "x"
    closeB.TextColor3 = MUTED; closeB.Font = Enum.Font.GothamBold
    closeB.TextSize = 12; closeB.AutoButtonColor = false; closeB.ZIndex = 12
    mkCorner(closeB, 7); mkStroke(closeB, STROKE_C, 1, 0.2)
    closeB.MouseEnter:Connect(function() tw(closeB, 0.1, {TextColor3 = TXT}) end)
    closeB.MouseLeave:Connect(function() tw(closeB, 0.1, {TextColor3 = MUTED}) end)
    closeB.MouseButton1Click:Connect(function()
        cfgOpen = false; csg:Destroy(); cfgPanel = nil
        tw(gearBtn, 0.15, {TextColor3 = MUTED})
    end)

    local div = Instance.new("Frame", panel)
    div.Size = UDim2.new(1,-28,0,1); div.Position = UDim2.new(0,14,0,55)
    div.BackgroundColor3 = STROKE_C; div.BorderSizePixel = 0; div.ZIndex = 11

    local scroll = Instance.new("ScrollingFrame", panel)
    scroll.Size = UDim2.new(1,-4,1,-62); scroll.Position = UDim2.new(0,2,0,60)
    scroll.BackgroundTransparency = 1; scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3; scroll.ScrollBarImageColor3 = C(80,80,110)
    scroll.CanvasSize = UDim2.new(0,0,0,0); scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ZIndex = 11

    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0,6)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local pad = Instance.new("UIPadding", scroll)
    pad.PaddingTop = UDim.new(0,6); pad.PaddingBottom = UDim.new(0,8)

    local layoutOrder = 0

    local function mkSection(txt)
        layoutOrder = layoutOrder + 1
        local s = Instance.new("TextLabel", scroll)
        s.Size = UDim2.new(0.94,0,0,18)
        s.BackgroundTransparency = 1
        s.Text = txt
        s.TextColor3 = MUTED; s.Font = Enum.Font.GothamBold; s.TextSize = 10
        s.TextXAlignment = Enum.TextXAlignment.Left; s.ZIndex = 12
        s.LayoutOrder = layoutOrder
    end

    local function mkToggleRow(label, state, onChange)
        layoutOrder = layoutOrder + 1
        local row = Instance.new("Frame", scroll)
        row.Size = UDim2.new(0.94,0,0,46)
        row.BackgroundColor3 = ROW; row.BorderSizePixel = 0; row.ZIndex = 12
        row.LayoutOrder = layoutOrder
        mkCorner(row, 12)
        mkStroke(row, STROKE_C, 1, 0)

        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0,150,1,0); lbl.Position = UDim2.new(0,14,0,0)
        lbl.BackgroundTransparency = 1; lbl.Text = label
        lbl.TextColor3 = TXT; lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 13

        local pill = Instance.new("Frame", row)
        pill.Size = UDim2.new(0,44,0,24); pill.Position = UDim2.new(1,-56,0.5,-12)
        pill.BackgroundColor3 = state and C(50,55,80) or C(38,38,50)
        pill.BorderSizePixel = 0; pill.ZIndex = 13
        mkCorner(pill, 12)

        local dot = Instance.new("Frame", pill)
        dot.Size = UDim2.new(0,18,0,18)
        dot.Position = state and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
        dot.BackgroundColor3 = state and C(220,220,255) or C(110,110,130)
        dot.BorderSizePixel = 0; dot.ZIndex = 14
        mkCorner(dot, 9)

        local hit = Instance.new("TextButton", row)
        hit.Size = UDim2.new(1,0,1,0); hit.BackgroundTransparency = 1
        hit.Text = ""; hit.ZIndex = 15; hit.AutoButtonColor = false

        local cur = state
        hit.MouseEnter:Connect(function() tw(row,0.1,{BackgroundColor3=HOVER}) end)
        hit.MouseLeave:Connect(function() tw(row,0.1,{BackgroundColor3=ROW}) end)
        hit.MouseButton1Click:Connect(function()
            cur = not cur
            tw(dot, 0.2, {
                Position = cur and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9),
                BackgroundColor3 = cur and C(220,220,255) or C(110,110,130)
            })
            tw(pill, 0.2, {BackgroundColor3 = cur and C(50,55,80) or C(38,38,50)})
            onChange(cur)
        end)
    end

    local function mkSliderRow(label, min, max, val, onChange)
        layoutOrder = layoutOrder + 1
        local row = Instance.new("Frame", scroll)
        row.Size = UDim2.new(0.94,0,0,56)
        row.BackgroundColor3 = ROW; row.BorderSizePixel = 0; row.ZIndex = 12
        row.LayoutOrder = layoutOrder
        mkCorner(row, 12)
        mkStroke(row, STROKE_C, 1, 0)

        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(1,-20,0,18); lbl.Position = UDim2.new(0,14,0,6)
        lbl.BackgroundTransparency = 1; lbl.Text = label..": "..val
        lbl.TextColor3 = TXT; lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 11
        lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 13

        local track = Instance.new("Frame", row)
        track.Size = UDim2.new(1,-28,0,6); track.Position = UDim2.new(0,14,0,32)
        track.BackgroundColor3 = C(30,30,40); track.BorderSizePixel = 0; track.ZIndex = 13
        mkCorner(track, 3)

        local fill = Instance.new("Frame", track)
        fill.Size = UDim2.new((val-min)/(max-min),0,1,0)
        fill.BackgroundColor3 = C(120,120,180); fill.BorderSizePixel = 0; fill.ZIndex = 14
        mkCorner(fill, 3)

        local handle = Instance.new("TextButton", track)
        handle.Size = UDim2.new(0,14,0,14); handle.AnchorPoint = Vector2.new(0.5,0.5)
        handle.Position = UDim2.new((val-min)/(max-min),0,0.5,0)
        handle.BackgroundColor3 = C(180,180,220); handle.Text = ""; handle.AutoButtonColor = false
        handle.ZIndex = 15
        mkCorner(handle, 7)

        local dragging = false
        handle.MouseButton1Down:Connect(function() dragging = true end)
        UIS.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
        end)
        UIS.InputChanged:Connect(function(i)
            if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
                local rel = math.clamp((i.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                local v = math.floor(min + rel*(max-min))
                fill.Size = UDim2.new(rel,0,1,0)
                handle.Position = UDim2.new(rel,0,0.5,0)
                lbl.Text = label..": "..v
                onChange(v)
            end
        end)
    end

    local function mkKeybindRow(name)
        layoutOrder = layoutOrder + 1
        local row = Instance.new("Frame", scroll)
        row.Size = UDim2.new(0.94,0,0,42)
        row.BackgroundColor3 = ROW; row.BorderSizePixel = 0; row.ZIndex = 12
        row.LayoutOrder = layoutOrder
        mkCorner(row, 12)
        mkStroke(row, STROKE_C, 1, 0)

        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0,130,1,0); lbl.Position = UDim2.new(0,14,0,0)
        lbl.BackgroundTransparency = 1; lbl.Text = name
        lbl.TextColor3 = TXT; lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 11
        lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 13

        local kbBtn = Instance.new("TextButton", row)
        kbBtn.Size = UDim2.new(0,80,0,26); kbBtn.Position = UDim2.new(1,-92,0.5,-13)
        kbBtn.BackgroundColor3 = C(25,25,34); kbBtn.BorderSizePixel = 0
        kbBtn.Text = CFG.keybinds[name] or "— NONE —"
        kbBtn.TextColor3 = CFG.keybinds[name] and TXT or MUTED
        kbBtn.Font = Enum.Font.GothamBold; kbBtn.TextSize = 10
        kbBtn.AutoButtonColor = false; kbBtn.ZIndex = 13
        mkCorner(kbBtn, 8)
        mkStroke(kbBtn, STROKE_C, 1, 0.3)

        kbBtn.MouseEnter:Connect(function() tw(kbBtn,0.1,{BackgroundColor3=C(32,32,44)}) end)
        kbBtn.MouseLeave:Connect(function() tw(kbBtn,0.1,{BackgroundColor3=C(25,25,34)}) end)
        kbBtn.MouseButton1Click:Connect(function()
            if listeningFor == name then
                listeningFor = nil
                kbBtn.Text = CFG.keybinds[name] or "— NONE —"
                kbBtn.TextColor3 = CFG.keybinds[name] and TXT or MUTED
                tw(kbBtn,0.15,{BackgroundColor3=C(25,25,34)})
                return
            end
            listeningFor = name
            kbBtn.Text = "PRESS KEY..."
            kbBtn.TextColor3 = C(180,180,220)
            tw(kbBtn,0.15,{BackgroundColor3=C(40,40,60)})

            task.spawn(function()
                while listeningFor == name do task.wait(0.05) end
                kbBtn.Text = CFG.keybinds[name] or "— NONE —"
                kbBtn.TextColor3 = CFG.keybinds[name] and TXT or MUTED
                tw(kbBtn,0.15,{BackgroundColor3=C(25,25,34)})
                local ref = btnRefs[name]
                if ref then ref.kbLbl.Text = CFG.keybinds[name] or "" end
            end)
        end)
    end

    -- CONTENT
    mkSection("  SPINBOT")
    mkSliderRow("Spin Speed", 1, 25, CFG.spinSpeed, function(v) CFG.spinSpeed = v; if spinForce then spinForce.AngularVelocity = Vector3.new(0,v,0) end end)

    mkSection("  BOOSTER")
    mkSliderRow("Normal Speed",  28, 70, CFG.boosterNormal, function(v) CFG.boosterNormal = v end)
    mkSliderRow("Steal Speed",   10, 40, CFG.boosterSteal,  function(v) CFG.boosterSteal  = v end)

    mkSection("  EXTRAS")
    mkToggleRow("Spd Head", CFG.spdHead, function(on)
        CFG.spdHead = on
        if on then
            spdHeadLbl = buildSpdHead()
        else
            if spdHeadBB then spdHeadBB:Destroy(); spdHeadBB = nil end
            spdHeadLbl = nil
        end
    end)

    mkSection("  KEYBINDS  (click p/ setar, ESC p/ limpar)")
    for _, name in ipairs(buttonDefs) do
        mkKeybindRow(name)
    end

    layoutOrder = layoutOrder + 1
    local saveRow = Instance.new("TextButton", scroll)
    saveRow.Size = UDim2.new(0.94,0,0,40)
    saveRow.BackgroundColor3 = ROW; saveRow.BorderSizePixel = 0
    saveRow.Text = "SAVE CONFIG"
    saveRow.TextColor3 = MUTED; saveRow.Font = Enum.Font.GothamBlack
    saveRow.TextSize = 12; saveRow.AutoButtonColor = false; saveRow.ZIndex = 12
    saveRow.LayoutOrder = layoutOrder
    mkCorner(saveRow, 12)
    mkGlow(saveRow)
    saveRow.MouseEnter:Connect(function() tw(saveRow,0.1,{BackgroundColor3=HOVER}) end)
    saveRow.MouseLeave:Connect(function() tw(saveRow,0.1,{BackgroundColor3=ROW}) end)
    saveRow.MouseButton1Click:Connect(function()
        saveCfg(CFG)
        saveRow.Text = "SAVED"
        tw(saveRow,0.15,{TextColor3=TXT})
        task.delay(1.5, function()
            saveRow.Text = "SAVE CONFIG"
            tw(saveRow,0.15,{TextColor3=MUTED})
        end)
    end)

    layout.Changed:Connect(function()
        local h = math.min(layout.AbsoluteContentSize.Y + 80, 520)
        tw(panel, 0.2, {Size = UDim2.new(0, W, 0, h)})
    end)

    local dragging, ds, dsp = false, nil, nil
    panel.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging=true; ds=inp.Position; dsp=panel.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then dragging=false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local d = inp.Position - ds
            panel.Position = UDim2.new(dsp.X.Scale, dsp.X.Offset+d.X, dsp.Y.Scale, dsp.Y.Offset+d.Y)
        end
    end)
end

gearBtn.MouseButton1Click:Connect(function()
    cfgOpen = not cfgOpen
    if cfgOpen then
        tw(gearBtn, 0.15, {TextColor3 = TXT})
        buildCfgPanel()
    else
        tw(gearBtn, 0.15, {TextColor3 = MUTED})
        if cfgPanel then cfgPanel:Destroy(); cfgPanel = nil end
    end
end)

-- ============================================================
-- HUD STATS UPDATE
-- ============================================================
local fpsValues = {}
local lastT = tick()

RunService.RenderStepped:Connect(function()
    local now = tick()
    local dt = now - lastT; lastT = now
    if dt > 0 then
        table.insert(fpsValues, 1/dt)
        if #fpsValues > 10 then table.remove(fpsValues,1) end
        local sum=0
        for _,v in ipairs(fpsValues) do sum = sum + v end
        local avg = sum/#fpsValues
        fpsVal.Text = string.format("%.0f", avg)
        fpsVal.TextColor3 = avg>=55 and C(100,220,140) or avg>=30 and C(220,200,80) or C(220,80,80)
    end

    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local v = hrp.AssemblyLinearVelocity
        local sp = math.floor(math.sqrt(v.X^2+v.Z^2))
        spdVal.Text = tostring(sp)
        if spdHeadLbl and spdHeadLbl.Parent then
            spdHeadLbl.Text = sp.." sp"
        end
    end
end)

task.spawn(function()
    while true do
        pcall(function()
            local stats = game:GetService("Stats")
            local ping = stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            pingVal.Text = string.format("%.0f", ping)
            pingVal.TextColor3 = ping<=80 and C(100,220,140) or ping<=150 and C(220,200,80) or C(220,80,80)
        end)
        task.wait(1)
    end
end)

print("Akaza Duels loaded")