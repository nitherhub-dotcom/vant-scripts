-- Protection by Cat
local _KEY=""
local _ok,_raw=pcall(function()
  return game:HttpGet("https://raw.githubusercontent.com/nitherhub-dotcom/vant-scripts/main/_sc594af480d2a6ddea3a0.txt")
end)
if not _ok or not _raw then error("[Cat] Could not verify key.") return end
local _st=_raw:match("^([^\n:]+)")
if not _st then error("[Cat] Bad status file.") return end
_st=_st:match("^%s*(.-)%s*$")
if _st~="ACTIVE" and _st~="REDEEMED" then error("[Cat] Key expired or revoked.") return end
-- Username check
local _locked=_raw:match("^[^:]+:(.+)")
if _locked and #_locked>0 then
  local _me=game.Players.LocalPlayer.Name
  if _me:lower()~=_locked:lower():match("^%s*(.-)%s*$") then
    game.Players.LocalPlayer:Kick("[Cat] This key is locked to another user.") return
  end
end

print('hi')