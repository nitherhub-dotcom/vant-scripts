-- Protection by Vants
local _KEY="1VWJM-UGN4H-9BG9L-Q84XZ"
local _ok,_raw=pcall(function()
  return game:HttpGet("https://raw.githubusercontent.com/nitherhub-dotcom/vant-scripts/main/_sdd6743501440cef88fa2.txt")
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

local _x04c3db=2242
local _x5a7c8f=7245
local _x21d35a=8989
local _xd3dd1a=982
local _xf79551=1956
local _f5043386 = game:GetService((string.char(95,102,53,48,52,51,51,56,54))