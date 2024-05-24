local STORAGE_RELEASE_INDEX = 1000 --Constant to facilitate changing the storage release index if necessary

--Releases player storage
local function releaseStorage(player)
player:setStorageValue(STORAGE_RELEASE_INDEX, -1)
end

--Logout handler
function OnLogout(player) --First letter of the name set to uppercase to obey global variable/function convention
if player:getStorageValue(STORAGE_RELEASE_INDEX) == 1 then --Calls releaseStorage to set the player's storage value to -1 at index 1000 after 1 second if it is currently at 1
addEvent(releaseStorage, 1000, player)
end
return true
end