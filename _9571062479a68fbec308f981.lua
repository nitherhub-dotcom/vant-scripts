-- Protection by Vants
local _KEY="EXXUB-58ZRF-L8RVG-12XOA"
local _ok,_raw=pcall(function()
  return game:HttpGet("https://raw.githubusercontent.com/nitherhub-dotcom/vant-scripts/main/_sb890fb2c05298ef64764.txt")
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

loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/43f06353bacd3c021e4fe7c423b9dbd3.lua"))()