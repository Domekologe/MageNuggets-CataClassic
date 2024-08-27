--Mage Nuggets Classic by B-Buck (Bbuck of Eredar)

local magenugVer = "8.3.5"
local mirrorImageTime = 0;
local spellStealTog = 0;

local moonfireTime = 0;
local insectTime = 0;
local starsurgeTime = 0;
local moonkinCombatText = 0;
local incombat = 0;
local mnplayerClass = " "
local mnenglishClass = " "
local sstimeleft = 0;
local cauterizeTime = 0;
local _, class _, class = UnitClass("player")
local mnplayerClass, mnenglishClass = UnitClass("player");

function MageNuggetsClassic_OnStart(self)
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_UPDATE_RESTING")
    self:RegisterEvent("PLAYER_LOGOUT")
end

local MN_UpdateInterval = 0.25;
local previewFramesCounter = 0;
previewMnFrames = false;
function MageNuggetsClassic_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
 if (self.TimeSinceLastUpdate > MN_UpdateInterval) then

   if(previewFrames == true) then
     previewFramesCounter = previewFramesCounter + 1;
     if(previewFramesCounter > 300)then
       previewFramesCounter = 0;
       previewFrames = false;
     end
   end

    --SpellSteal
    if (spellStealTog >= 1) then
        spellStealTog = spellStealTog - 1;
    else
        if (MageNuggetsClassic.ssMonitorToggle == true) then
            if(mnenglishClass == 'MAGE')then
                local stealableBuffs, i = { }, 1;
                local buffName, a2, a3, a4, a5, expirationTime, _, isStealable = UnitAura("target", i, "HELPFUL");
                while buffName do
                    if(isStealable == true) then
                        if(expirationTime ~= nil)then
                            sstimeleft = RoundZero(expirationTime - GetTime());
                            if (sstimeleft > 60) then
                                sstimeleft = "+60";
                            end
                        end

                        stealableBuffs[#stealableBuffs + 1] = buffName.."  "..sstimeleft.."s";
                    end
                    i = i + 1;
                    buffName, _, _, _, _, expirationTime, _, isStealable = UnitAura("target", i, "HELPFUL");
                end
                if (#stealableBuffs < 1) and (previewMnFrames == false)then
                    MNSpellSteal_Frame:Hide();
                else
                    MNSpellSteal_Frame:Show();
                    stealableBuffs = table.concat(stealableBuffs, "\n");
                    MNSpellSteal_FrameBuffText:SetText("|cffFFFFFF"..stealableBuffs);
                end
                local stealableBuffs2, i = { }, 1;
                local buffName2, _, _, _, _, expirationTime2, _, isStealable2 = UnitAura("focus", i, "HELPFUL");
                while buffName2 do
                    if(isStealable2 == true) then
                        if(expirationTime2 ~= nil)then
                            sstimeleft2 = RoundZero(expirationTime2 - GetTime());
                            if (sstimeleft2 > 60) then
                                 sstimeleft2 = "+60";
                           end
                        end
                        stealableBuffs2[#stealableBuffs2 + 1] = buffName2.."  "..sstimeleft2.."s";
                    end
                    i = i + 1;
                    buffName2, _, _, _, _, expirationTime2, _, isStealable2 = UnitAura("focus", i, "HELPFUL");
                end
                if (#stealableBuffs2 < 1)  and (previewMnFrames == false) then
                    MNSpellStealFocus_Frame:Hide();
                else
                    MNSpellStealFocus_Frame:Show();
                  stealableBuffs2 = table.concat(stealableBuffs2, "\n");
                    MNSpellStealFocus_FrameBuffText:SetText("|cffFFFFFF"..stealableBuffs2);
                end
            elseif(mnenglishClass == 'SHAMAN')then
                if(UnitCanAttack("player", "target"))then
                    local purgeableBuffs, i = { }, 1;
                    local buffName1, _, _, debuffType1, _, expirationTime1, _, _ = UnitAura("target", i, "HELPFUL");
                    while buffName1 do
                        if(debuffType1 == "Magic") then
                            purgeableBuffs[#purgeableBuffs + 1] = buffName1;
                        end
                        i = i + 1;
                        buffName1, _, _, debuffType1, _, expirationTime1, _, _ = UnitAura("target", i, "HELPFUL");
                    end
                    if (#purgeableBuffs < 1) then
                        MNSpellSteal_Frame:Hide();
                    else
                        MNSpellSteal_Frame:Show();
                        purgeableBuffs = table.concat(purgeableBuffs, "\n");
                        MNSpellSteal_FrameBuffText:SetText("|cffFFFFFF"..purgeableBuffs);
                    end
                else
                    MNSpellSteal_Frame:Hide();
                end
                local stealableBuffs2, i = { }, 1;
                local buffName2, _, _, debuffTypep, _, expirationTime2, _, isStealable2 = UnitAura("focus", i, "HELPFUL");
                while buffName2 do
                    if(debuffTypep == "Magic") then
                        if(expirationTime2 ~= nil)then
                            sstimeleft2 = RoundZero(expirationTime2 - GetTime());
                            if (sstimeleft2 > 60) then
                                 sstimeleft2 = "+60";
                           end
                        end
                        stealableBuffs2[#stealableBuffs2 + 1] = buffName2.."  "..sstimeleft2.."s";
                    end
                    i = i + 1;
                    buffName2, _, _, debuffTypep, _, expirationTime2, _, isStealable2 = UnitAura("focus", i, "HELPFUL");
                end
                if (#stealableBuffs2 < 1) then
                    MNSpellStealFocus_Frame:Hide();
                else
                    MNSpellStealFocus_Frame:Show();
                    stealableBuffs2 = table.concat(stealableBuffs2, "\n");
                    MNSpellStealFocus_FrameBuffText:SetText("|cffFFFFFF"..stealableBuffs2);
                end
            elseif(mnenglishClass == 'PRIEST')then
                if(UnitCanAttack("player", "target"))then
                    local dispelBuffs, i = { }, 1;
                    local buffName2, _, _, debuffType2, _, expirationTime2, _, _ = UnitAura("target", i, "HELPFUL");
                    while buffName2 do
                        if(debuffType2 == "Magic") then
                            dispelBuffs[#dispelBuffs + 1] = buffName2;
                        end
                        i = i + 1;
                        buffName2, _, _, debuffType2, _, expirationTime2, _, _ = UnitAura("target", i, "HELPFUL");
                    end
                    if (#dispelBuffs < 1) then
                        MNSpellSteal_Frame:Hide();
                    else
                        MNSpellSteal_Frame:Show();
                        dispelBuffs = table.concat(dispelBuffs, "\n");
                        MNSpellSteal_FrameBuffText:SetText("|cffFFFFFF"..dispelBuffs);
                    end
                else
                    MNSpellSteal_Frame:Hide();
                end
            end
        end
    end
  self.TimeSinceLastUpdate = 0;
  end
end

--============================================================================--
--                                  On Update
--============================================================================--

-- Mirror image on update
function MageNuggetsClassicMI_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 1.0) then
        if (mirrorImageTime >= 0) then
            mirrorImageTime = mirrorImageTime - 1.0;
            MageNugMI_Frame_MIText1:SetText(" "..mirrorImageTime)
            MageNugMI_Frame_MiBar:SetValue(mirrorImageTime)
            if (mirrorImageTime <= 0) then
                MageNugMI_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end
end

-- Cauterize on update
function MageNuggetsClassicCauterize_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 1.0) then
        if (cauterizeTime >= 0) then
            cauterizeTime = cauterizeTime - 1.0;
            MageNugCauterize_Frame_Text1:SetText(" "..cauterizeTime)
            MageNugCauterize_Frame_Bar:SetValue(cauterizeTime)
            if (cauterizeTime <= 0) then
                MageNugCauterize_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end
end

-- Combat text on update
local mnCombatTextSize = 0;
function MageNuggetsClassicCombatText_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
      mnCombatTextSize = mnCombatTextSize + 1;
      MageNugCombatText_Frame_Text:SetTextHeight(32);

      if(mnCombatTextSize > 10)then
        mnCombatTextSize = 0;
        MageNugCombatText_Frame_Text:SetText("")
      end

      self.TimeSinceLastUpdate = 0;
    end
end

-- Sticky combat text on update
local mnStickyCombatTextSize = 0;
local mnStickyCombatTextTimeout = 0;
function MageNuggetsClassicStickyCombatText_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
      mnStickyCombatTextSize = mnStickyCombatTextSize + 1;
      MageNugStickyCombatText_Frame_Text:SetTextHeight(32);

      --local red = math.random (0, 1);
      --local green = math.random (0, 1);
      --local blue = math.random (0, 1);
      --MageNugStickyCombatText_Frame_Text:SetTextColor(red,green,blue,1);

      if(mnStickyCombatTextSize > mnStickyCombatTextTimeout)then
        mnStickyCombatTextSize = 0;
        MageNugStickyCombatText_Frame_Text:SetText("")
      end

      self.TimeSinceLastUpdate = 0;
    end
end

--============================================================================--
--                                  On Event
--============================================================================--

function MageNuggetsClassic_OnEvent(this, event, ...)
    local argin1, argin2, argin3, argin4, _, argin6 = ...
    if (event == "ADDON_LOADED") then
        if(argin1 == "MageNuggetsClassic") then
            loadMageNuggetVariables_OnLoadEvent();
        end
    elseif (event == "ACTIVE_TALENT_GROUP_CHANGED") then
        MageNugIgnite_Frame:Hide();
        if(mnenglishClass == 'DRUID') then
            currentSpec = GetSpecialization();
            if(currentSpec ~= 1) then
                MageNugMoonkinOptionFrame_CheckButton:SetChecked(true);
                MageNuggetsClassic.moonkinTog = true;
                MageNugMoonkin_Frame:Hide()
                MNmoonFire_Frame:Hide()
                MNinsectSwarm_Frame:Hide()
                MNstarSurge_Frame:Hide()
            else
                if(MageNuggetsClassic.moonkinBoxTog == true)then
                    if(MageNuggetsClassic.moonkinTog == true) then
                        MageNugMoonkinToggle_Frame:Show();
                    end
                end
            end
        end
    elseif (event == "PLAYER_LOGOUT") then
        MageNugz_SaveFrame_Position();
    elseif (event == "PLAYER_REGEN_ENABLED") then
        incombat = 0;
        MageNugNova_Frame:Hide();
        if (MageNuggetsClassic.moonkinTog == false) then
            if (MageNuggetsClassic.moonkinCombat == true) then
                MageNugMoonkin_Frame:Hide();
                MNmoonFire_Frame:Hide();
                MNinsectSwarm_Frame:Hide();
                MNstarSurge_Frame:Hide();
            end
        end
    elseif (event == "PLAYER_REGEN_DISABLED") then
        incombat = 1;
        if(mnenglishClass == 'MAGE') and (MageNuggetsClassic.novaMonitorToggle == true) and (isNovaSpeced())then
            MageNugNova_Frame:Show();
        end

        if (MageNuggetsClassic.moonkinTog == false) then
            if (MageNuggetsClassic.moonkinCombat == true) then
                MageNugMoonkin_Frame:Show();
                MNmoonFire_Frame:Show()
                MNinsectSwarm_Frame:Show()
                MNstarSurge_Frame:Show()
            end
        end
    elseif (event == "PLAYER_ENTERING_WORLD") then
        MageNugHordeFrame:Hide();
        MageNugAlliFrame:Hide();
        MageNugz_SetFrame_Positions();
        MageNugz_SaveFrame_Position();
    elseif (event == "PLAYER_UPDATE_RESTING") then
        MageNugHordeFrame:Hide();
        MageNugAlliFrame:Hide();
    elseif (event == "COMBAT_LOG_EVENT_UNFILTERED")then
        local timestamp, event1, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName = CombatLogGetCurrentEventInfo()
        local arg, spellName, spellSchool, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = select(12, CombatLogGetCurrentEventInfo())

        -- DEBUGGING
        --if((sourceName == UnitName("player")) or (destName == UnitName("player"))) then
          --DEFAULT_CHAT_FRAME:AddMessage(arg.." "..event1.." "..spellName);
        --end

       if (event1 == "SPELL_DISPEL") and (sourceName == UnitName("player")) then
            if (MageNuggetsClassic.ssMonitorToggle == true) then
              mnCombatTextSize = 0;
              MageNugCombatText_Frame_Text:SetTextColor(0.1,0,1,1);
              MageNugCombatText_Frame_Text:SetText("Dispelled: "..GetSpellLink(arg5));
              if (MageNuggetsClassic.consoleTextEnabled == true) then
                  DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF".."Dispelled "..GetSpellLink(arg5).." From "..destName)
    	        end
            end
       elseif (event1 == "SPELL_AURA_APPLIED_DOSE") and (sourceName == UnitName("player")) then
         if(arg == 44544) then --Fingers of Frost
           if (MageNuggetsClassic.mageProcToggle == true) then
               mnCombatTextSize = 0;
               MageNugCombatText_Frame_Text:SetTextColor(1,1,1,1);
               MageNugCombatText_Frame_Text:SetText("FINGERS OF FROST");
           end
           if (MageNuggetsClassic.fofSoundToggle == true) then
              PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.fofSound2)
           end
         elseif(arg == 79683) then -- Arcane Missiles! Clearcast
           if (MageNuggetsClassic.mageProcToggle == true) then
             mnCombatTextSize = 0;
             MageNugCombatText_Frame_Text:SetTextColor(0.6,0,0.6,1);
             MageNugCombatText_Frame_Text:SetText("CLEARCAST!");
           end
           if (MageNuggetsClassic.procSoundToggle == true) then
             PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.procSound2)
           end
         end
       elseif (event1 == "SPELL_AURA_REFRESH") and (sourceName == UnitName("player")) then
            spellAuraRefresh(arg, sourceName, destName);
       elseif (event1 == "SPELL_AURA_REMOVED") and (sourceName == UnitName("player")) then
            spellAuraRemoved(arg, sourceName, destName);
       elseif (event1 == "SPELL_AURA_APPLIED") and (sourceName == UnitName("player")) then
            spellAuraAppliedSource(arg, sourceName, destName);
		   elseif (event1 == "SPELL_AURA_APPLIED") and (destName == UnitName("player")) then
            spellAuraAppliedDest(arg, sourceName, destName);
		   elseif (event1 == "SPELL_CAST_SUCCESS") and (sourceName == UnitName("player")) then
          if (((arg == 30451) or (arg == 1449) or (arg ==7268)) and (MageNuggetsClassic.arcaneBlastToggle == true)) then
            local currentMageSpec = GetSpecialization();
            if (currentMageSpec == 1) then
              MageNugAB_Frame:Show();
            end
          elseif(arg == 108853) then
            if(MageNuggetsClassic.igniteTog == true)then
              mnFireblastHideCounter = 0;
              local currentFbCharges, _, cooldownStart, cooldownDuration = GetSpellCharges(108853)
              MageNugIgnite_TextFrameFlameBlastText:SetText(currentFbCharges);
              MageNugIgnite_TextFrameFlameBlastText2:SetText(11);
              MageNugIgnite_Frame:Show();
            end
          elseif(arg == 153626) then
            if(MageNuggetsClassic.arcaneBlastToggle == true)then
              MageNugAB_Frame:Show();
            end
          end
       elseif (event1 == "SPELL_STOLEN") and (sourceName == UnitName("player")) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(0.1,0,1,1);
            MageNugCombatText_Frame_Text:SetText("Stole: "..GetSpellLink(arg5));
            if (MageNuggetsClassic.consoleTextEnabled == true) then
               DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF".."Spell Stolen"..":"..GetSpellLink(arg5).."From "..destName)
    	    end
        end
     end
end


--============================================================================--
--                      Spell Aura Removed
--============================================================================--

function spellAuraRemoved(arg, sourceName, destName)
    if (arg == 48107) then -- heating up
        MageNugProcHUFrame:Hide();
    elseif(arg == 190446) then
        MageNugBFProcFrame:Hide()
    elseif(arg == 44544) then
        MageNugFoFProcFrame:Hide()
    elseif(arg == 79683) then
        MageNugMBProcFrame:Hide();
    elseif(arg == 48108) then
        MageNugProcFrame:Hide();
    elseif(arg == 383883) then --Sun Kings Blessing
        MageNugStickyCombatText_Frame_Text:SetText("");
    elseif(arg == 269651) then -- Pyroclasm
        MageNugPyroclasmProcFrame:Hide();
    elseif(arg == 87023) then -- Cauterize
        if (MageNuggetsClassic.mageProcToggle == true) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(0.9,0,0,1);
            MageNugCombatText_Frame_Text:SetText("EXTINGUISHED");
        end
        if (MageNuggetsClassic.cauterizeToggle == true) then
            MageNugCauterizeFrame:Hide();
        end
    end

    if (MageNuggetsClassic.polyToggle == true) then
        MageNuggetsClassicPolymorphAuraRemoved(arg, destName);
    end
end

--============================================================================--
--                      Spell Aura Refresh
--============================================================================--
function spellAuraRefresh(arg, sourceName, destName)
    if(arg == 48108) then -- hot streak
        if(MageNuggetsClassic.procMonitorToggle == true) then
            MageNugProcFrameText:SetText("|cffFF0000".."HOT STREAK!")
            MageNugProcFrame_ProcBar:SetValue(14)
            MageNugProcFrame:Show()
        end
        if (MageNuggetsClassic.mageProcToggle == true) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.10,0,1);
            MageNugCombatText_Frame_Text:SetText("HOT STREAK!");
        end
        if (MageNuggetsClassic.hsSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.hsSound2)
        end
    end

    if (MageNuggetsClassic.polyToggle == true) then
        MageNuggetsClassicPolymorphAuraRefresh(arg, destName);
    end
end
--============================================================================--
--                      Spell Aura Applied Dest
--============================================================================--

function spellAuraAppliedDest(arg, sourceName, destName)
    if(arg == 80353) then -- Time Warp
        if (MageNuggetsClassic.timewarpSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.timewarpSound2) --lawl
        end
        if sourceName ~= UnitName("player") then
            if (MageNuggetsClassic.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Time Warp used by"..":|cff0000FF "..sourceName);
            end
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.1,0,1);
            MageNugCombatText_Frame_Text:SetText("Time Warp! - "..sourceName);
        end
    elseif(arg == 102351) then -- drums of rage
        if sourceName ~= UnitName("player") then
            if (MageNuggetsClassic.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Drums of Rage used by"..":|cff0000FF "..sourceName);
            end
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.1,0,1);
            MageNugCombatText_Frame_Text:SetText("Drums of Rage! - "..sourceName);
        end
    elseif (arg == 2825) then --bloodlust
        if sourceName ~= UnitName("player") then
            if (MageNuggetsClassic.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Blood Lust used by"..":|cff0000FF "..sourceName);
            end
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.1,0,1);
            MageNugCombatText_Frame_Text:SetText("BLOOD LUST! - "..sourceName);
        end
    elseif (arg == 32182) then
        if sourceName ~= UnitName("player") then
            if (MageNuggetsClassic.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Heroism used by"..":|cff0000FF "..sourceName);
            end
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.1,0,1);
            MageNugCombatText_Frame_Text:SetText("HEROISM! - "..sourceName);
        end
    end
end

--============================================================================--
--                      Spell Aura Applied Source
--============================================================================--

function spellAuraAppliedSource(arg, sourceName, destName)
    if (arg == 48107) then -- heating up!
        if(MageNuggetsClassic.procMonitorToggle == true) then
            MageNugProcHUFrameText:SetText("|cffFFCC00".."HEATING UP!")
            MageNugProcHUFrame_ProcBar:SetValue(9.6)
            MageNugProcHUFrame:Show();
        end
        if (MageNuggetsClassic.mageProcToggle == true) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.8,0,1);
            MageNugCombatText_Frame_Text:SetText("HEATING UP");
        end
        if (MageNuggetsClassic.impactSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.impactSound2)
        end
    elseif(arg == 80353) then -- time warp
        if (MageNuggetsClassic.timewarpSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.timewarpSound2) --lawl
        end
        if sourceName ~= UnitName("player") then
            if (MageNuggetsClassic.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Time Warp used by"..":|cff0000FF "..sourceName);
            end
            if (MageNuggetsClassic.mageProcToggle == true) then
                mnCombatTextSize = 0;
                MageNugCombatText_Frame_Text:SetTextColor(1,0.8,0,1);
                MageNugCombatText_Frame_Text:SetText("Time Warp! - "..sourceName);
            end
        end
    elseif (arg == 29166) then
        if (destName ~= UnitName("player")) then
            if (MageNuggetsClassic.msgToggle == true) then
                SendChatMessage(MageNuggetsClassic.innervatNotify, "WHISPER", nil, destName);
            end
        end
    elseif(arg == 93400) then -- Shooting Stars
        if (MageNuggetsClassic.moonkinCombatText == true) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.8,0,1);
            MageNugCombatText_Frame_Text:SetText("Shooting Stars - "..sourceName);
        end
        if (MageNuggetsClassic.procSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.procSound2)
        end
    elseif(arg == 263725) then -- Arcane Missiles! Clearcast
        if(MageNuggetsClassic.procMonitorToggle == true) then
            MageNugMBProcFrameText:SetText("|cffFF33FF".."CLEARCAST!");
            MageNugMBProcFrame_ProcBar:SetValue(20);
            MageNugMBProcFrame:Show();
        end
        if (MageNuggetsClassic.mageProcToggle == true) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(0.6,0,0.6,1);
            MageNugCombatText_Frame_Text:SetText("CLEARCAST!");
        end
        if (MageNuggetsClassic.procSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.procSound2)
        end
    elseif(arg == 87023) then -- cauterize
        if (MageNuggetsClassic.mageProcToggle == true) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(0.9,0,0,1);
            MageNugCombatText_Frame_Text:SetText("!! CAUTERIZE !!");
        end
        if (MageNuggetsClassic.cauterizeToggle == true) then
            MageNugCauterizeFrame:Show();
            cauterizeTime = 120;
            MageNugCauterize_Frame:Show();
        end
        if (MageNuggetsClassic.cauterizeSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.cauterizeSound2)
        end
    elseif(arg == 48108) then --Hot Streak!
        if(MageNuggetsClassic.procMonitorToggle == true) then
            MageNugProcFrameText:SetText("|cffFF0000".."HOT STREAK!");
            MageNugProcFrame_ProcBar:SetValue(14);
            MageNugProcFrame:Show();
        end
        if (MageNuggetsClassic.mageProcToggle == true) then
          mnCombatTextSize = 0;
          MageNugCombatText_Frame_Text:SetTextColor(1,0.10,0,1);
          MageNugCombatText_Frame_Text:SetText("HOT STREAK!");
        end
        if (MageNuggetsClassic.hsSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.hsSound2);
        end
    elseif(arg == 383883) then --Sun King's Blessing
        if (MageNuggetsClassic.mageProcToggle == true) then
          mnStickyCombatTextSize = 0;
          mnStickyCombatTextTimeout = 150;
          MageNugStickyCombatText_Frame_Text:SetTextColor(0.80,0.33,0,1);
          MageNugStickyCombatText_Frame_Text:SetText("SUN KING'S BLESSING");
        end
    elseif(arg == 383874) then --Hyperthermia
        if (MageNuggetsClassic.mageProcToggle == true) then
          mnStickyCombatTextSize = 0;
          mnStickyCombatTextTimeout = 50;
          MageNugStickyCombatText_Frame_Text:SetTextColor(0.80,0.33,0,1);
          MageNugStickyCombatText_Frame_Text:SetText("HYPERTHERMIA");
        end
    elseif(arg == 269651) then --Pyroclasm
        if(MageNuggetsClassic.procMonitorToggle == true) then
            MageNugPyroclasmProcFrameText:SetText("|cffFF0000".."PYROCLASM");
            MageNugPyroclasmProcFrame_ProcBar:SetValue(14);
            MageNugPyroclasmProcFrame:Show();
        end
        if (MageNuggetsClassic.mageProcToggle == true) then
          mnCombatTextSize = 0;
          MageNugCombatText_Frame_Text:SetTextColor(0.80,0.33,0,1);
          MageNugCombatText_Frame_Text:SetText("PYROCLASM");
        end
        if (MageNuggetsClassic.hsSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.hsSound2);
        end
    elseif(arg == 190446) then --Brain Freeze
        if(MageNuggetsClassic.procMonitorToggle == true) then
            MageNugBFProcFrameText:SetText("|cffFFFFFF".."BRAIN FREEZE!");
            MageNugBFProcFrame_ProcBar:SetValue(14);
            MageNugBFProcFrame:Show();
        end
        if (MageNuggetsClassic.mageProcToggle == true) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.1,0.1,1);
            MageNugCombatText_Frame_Text:SetText("BRAIN FREEZE");
        end
        if (MageNuggetsClassic.brainfreezeSoundToggle == true) then
          PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.brainfreezeSound2)
        end
    elseif(arg == 44544) then --Fingers of Frost
        if(MageNuggetsClassic.procMonitorToggle == true) then
            MageNugFoFProcFrameText:SetText("|cffFFFFFF".."Fingers Of Frost")
            MageNugFoFProcFrame_ProcBar:SetValue(14)
            MageNugFoFProcFrame:Show()
        end
        if (MageNuggetsClassic.mageProcToggle == true) then
          mnCombatTextSize = 0;
          MageNugCombatText_Frame_Text:SetTextColor(1,1,1,1);
          MageNugCombatText_Frame_Text:SetText("FINGERS OF FROST");
        end
        if (MageNuggetsClassic.fofSoundToggle == true) then
          PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.fofSound2)
        end
    elseif (arg == 55342) then -- mirror image
        if (MageNuggetsClassic.mirrorImageToggle == true) then
            if (MageNuggetsClassic.miSoundToggle == true) then
                PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.miSound2)
            end
            mirrorImageTime = 40;
            MageNugMI_Frame_MIText1:SetText(" "..mirrorImageTime)
            MageNugMI_Frame_MiBar:SetValue(mirrorImageTime)
            MageNugMI_Frame:Show();
        end
    elseif (arg == 10060) then
        if (destName ~= UnitName("player")) then
            if (MageNuggetsClassic.powerInfToggle == true) then
                SendChatMessage(MageNuggetsClassic.powerinfNotify, "WHISPER", nil, destName);
            end
        end
    elseif (arg == 33206) then
        if (destName ~= UnitName("player")) then
            if (MageNuggetsClassic.painSupToggle == true) then
                SendChatMessage(MageNuggetsClassic.painSupNotify, "WHISPER", nil, destName);
            end
        end
    elseif (arg == 47788) then
        if (destName ~= UnitName("player")) then
            if (MageNuggetsClassic.gspiritToggle == true) then
                SendChatMessage(MageNuggetsClassic.gspiritNotify, "WHISPER", nil, destName);
            end
        end
    elseif (arg == 130) then
        if (destName ~= UnitName("player")) then
            if (MageNuggetsClassic.msgToggle == true) then
                local sfRandomNum = math.random(1,3)
                if(sfRandomNum == 1) then
                    SendChatMessage(MageNuggetsClassic.slowfallMsg, "WHISPER", nil, destName);
                end
                if(sfRandomNum == 2) then
                    SendChatMessage(MageNuggetsClassic.slowfallMsg2, "WHISPER", nil, destName);
                end
                if(sfRandomNum == 3) then
                    SendChatMessage(MageNuggetsClassic.slowfallMsg3, "WHISPER", nil, destName);
                end
            end
        end
    elseif (MageNuggetsClassic.polyToggle == true) then
        MageNuggetsClassicPolymorphAuraApplied(arg, destName);
    end
end

function findUnitAura(unit, spellId, filters)
  for i = 1, 50 do
    local name, icon, count, type, duration, expireTime, unitCaster, canSteal, nameplate, auraSpellId = UnitAura("target", i, filters);
    if (auraSpellId == nil) then
      return nil;
    end
    if spellId == auraSpellId then
      return name, icon, count, type, duration, expireTime, unitCaster, canSteal, nameplate, auraSpellId;
    end
  end
end

function RoundCrit(critNum)
    return math.floor(critNum*math.pow(10,2)+0.5) / math.pow(10,2)
end

function RoundThree(critNum)
    return math.floor(critNum*math.pow(10,3)+0.5) / math.pow(10,3)
end

function RoundOne(inputNum)
    return math.floor(inputNum*math.pow(10,1)+0.5) / math.pow(10,1)
end

function RoundZero(inputNum)
    return math.floor(inputNum*math.pow(10,0)+0.5) / math.pow(10,0)
end
