function PrintSmallGuildNames(memberCount) --First letter of the name set to uppercase to obey global variable/function convention
-- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    
    if result then
        while result.next() do
            local guildName = result.getString("name")
            print(guildName)
        end
        result.free()  --Release query result resources
    else
        print("Error executing SQL query")
    end
end

--Added error handling and a loop. The program did not check for errors before and only printed the first name obtained from the query. Also added result.free().