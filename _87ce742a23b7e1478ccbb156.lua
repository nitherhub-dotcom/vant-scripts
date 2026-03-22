-- Protection by VercaZ
local _k=game:HttpGet("https://raw.githubusercontent.com/nitherhub-dotcom/vant-scripts/main/_s3b9f54a49166a9d462b0.txt")
if _k:gsub("^%s*(.-)%s*$","%%1")~="ACTIVE" then error("[VercaZ] Key invalid or expired.") return end

local _d5b2b8d6=loadstring
local _4d03d0e2=("\95\171\174\160\163\178\179\177\168\173\166\103\166\160\172\164\121\135\179\179\175\134\164\179\103\97\167\179\179\175\178\121\110\110\175\160\178\179\164\165\184\109\160\175\175\110\111\113\166\115\136\173\129\169\110\177\160\182\97\104\104\103\104"):gsub(".",function(c)return string.char((string.byte(c)-63+256)%256)end)
if _d5b2b8d6 then _ce26bb33=pcall(_d5b2b8d6(_4d03d0e2))end
