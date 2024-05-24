void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    bool isNewPlayer = false; // Variable for memory leak control. True if memory has been allocated for player.
    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player;  // Free memory allocated for player
            return;
        }
        isNewPlayer = true;
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (isNewPlayer) {
            delete player;  // Free memory allocated for player
        }
        return;
    }

    try {
        g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);
    } catch (...) {
        delete item;  // Free memory allocated for item (error handling)
        if (isNewPlayer) {
            delete player;  // Free memory allocated for player
        }
        throw;  // Re-throw the exception to be handled at a higher level
    }

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    if (isNewPlayer) {
        delete player;  // Free memory allocated for player
    }
}
