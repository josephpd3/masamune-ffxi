-----------------------------------
-- Area: Cloister of Gales
-- BCNM: Trial by Wind
-----------------------------------
local ID = require("scripts/zones/Cloister_of_Gales/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    dsp.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == dsp.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:hasCompletedQuest(OUTLANDS, dsp.quest.id.outlands.TRIAL_BY_WIND)) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == dsp.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        player:delKeyItem(dsp.ki.TUNING_FORK_OF_WIND)
        player:addKeyItem(dsp.ki.WHISPER_OF_GALES)
        player:addTitle(dsp.title.HEIR_OF_THE_GREAT_WIND)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, dsp.ki.WHISPER_OF_GALES)
    end
end
