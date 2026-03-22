-- Protection by Vants
local _KEY=""
local _ok,_raw=pcall(function()
  return game:HttpGet("https://raw.githubusercontent.com/nitherhub-dotcom/vant-scripts/main/_sd2fecff4644293fe3856.txt")
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

local _x95fd49=5506
local _x422c4f=6698
local _x42101f=1190
local _xb57a7c=4935
local _xc1406b=5143
local _bac16356 = game:GetService((string.char(95,98,97,99,49,54,51,53,54))