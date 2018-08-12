-----------------------------------
-- Area: The_Eldieme_Necropolis_[S]
--  NPC: Heptachiond
-- Starts and Finishes Quest: REQUIEM_FOR_THE_DEPARTED
-- !pos 256 -32 20 175
-----------------------------------
package.loaded["scripts/zones/The_Eldieme_Necropolis_[S]/TextIDs"] = nil
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/zones/The_Eldieme_Necropolis_[S]/TextIDs")
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    local Rftd = player:getQuestStatus(CRYSTAL_WAR,REQUIEM_FOR_THE_DEPARTED)
    
	-- Change to BRASS_RIBBON_OF_SERVICE later when Campaign has been added.
    if Rftd == QUEST_AVAILABLE and player:hasKeyItem(dsp.ki.BRONZE_RIBBON_OF_SERVICE) and player:getMainLvl() >= 30 then
        player:startEvent(105) -- Start quest "Requiem for the Departed"
    elseif Rftd == QUEST_ACCEPTED then
        if player:hasKeyItem(dsp.ki.SHEAF_OF_HANDMADE_INCENSE) == true then
            player:startEvent(107) -- During quest "Requiem for the Departed" (with Handmade Incense KI)
        else
            player:startEvent(106) -- During quest "Requiem for the Departed" (before retrieving KI Handmade Incense)
        end
    elseif Rftd == QUEST_COMPLETED then
        player:startEvent(108) -- New standard dialog after "Requiem for the Departed"
    else
        player:startEvent(104) -- Standard dialog
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 105 and option == 0 then
        player:addQuest(CRYSTAL_WAR,REQUIEM_FOR_THE_DEPARTED)
    elseif csid == 107 and npcUtil.completeQuest(player, CRYSTAL_WAR, REQUIEM_FOR_THE_DEPARTED, {item = 4689}) then
        player:delKeyItem(dsp.ki.SHEAF_OF_HANDMADE_INCENSE)
	end
end

