function removeMemberFromPlayerParty(playerId, membername) --Made the function name more descriptive, was extremely vague previously
local player = Player(playerId) --Variable "player" is now local, to not conflict with other possible variables named player
local party = player:getParty()

local members = party:getMembers() --Variable to increase the next line's readability
for k, v in pairs(members) do
if v:getName() == membername then --Changed object comparison to name/identifier comparison to prevent possible unexpected behavior
party:removeMember(Player(membername))
break --Break to stop the iteration, since removing the object in the middle of iteration can lead to unexpected behavior
end
end
end