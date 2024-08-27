--Mage Nuggets Classic Cooldown Monitor by B-Buck (Bbuck of Eredar)

local combatTextCvar = GetCVar("enableCombatText");

function MageNuggetsClassicCdMon_OnStart(self)
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("CVAR_UPDATE")
    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("CONFIRM_TALENT_WIPE")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterEvent("PLAYER_TALENT_UPDATE")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_UPDATE_RESTING")
    self:RegisterEvent("PLAYER_LOGOUT")
end

local MN_UpdateInterval = 0.25;
function MageNuggetsClassic_Cooldown_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
  if (self.TimeSinceLastUpdate > MN_UpdateInterval) then

    self.TimeSinceLastUpdate = 0;
  end
end


--============================================================================--
--                                  On Event
--============================================================================--

function MageNuggetsClassicCdMon_OnEvent(this, event, ...)
    local argin1, argin2, argin3, argin4, _, argin6 = ...
    if (event == "ADDON_LOADED") then
        if(argin1 == "MageNuggetsClassic_CooldownMonitor") then
            loadMageNuggetCdMonVariables_OnLoadEvent();
            MageNugzCdMon_SetFrame_Positions();
        end
    elseif (event == "ACTIVE_TALENT_GROUP_CHANGED") then
        MageNugCD1_Frame_Bar:SetValue(0);
        MageNugCD1_Frame:Hide();
        MageNugCD2_Frame_Bar:SetValue(0);
        MageNugCD2_Frame:Hide();
        MageNugCD3_Frame_Bar:SetValue(0);
        MageNugCD3_Frame:Hide();
        MageNugCD4_Frame_Bar:SetValue(0);
        MageNugCD4_Frame:Hide();
        MageNugCD5_Frame_Bar:SetValue(0);
        MageNugCD5_Frame:Hide();
        MageNugCD6_Frame_Bar:SetValue(0);
        MageNugCD6_Frame:Hide();
    elseif (event == "CONFIRM_TALENT_WIPE") then
        MageNugCD1_Frame_Bar:SetValue(0);
        MageNugCD1_Frame:Hide();
        MageNugCD2_Frame_Bar:SetValue(0);
        MageNugCD2_Frame:Hide();
        MageNugCD3_Frame_Bar:SetValue(0);
        MageNugCD3_Frame:Hide();
        MageNugCD4_Frame_Bar:SetValue(0);
        MageNugCD4_Frame:Hide();
        MageNugCD5_Frame_Bar:SetValue(0);
        MageNugCD5_Frame:Hide();
        MageNugCD6_Frame_Bar:SetValue(0);
        MageNugCD6_Frame:Hide();
    elseif (event == "PLAYER_LOGOUT") then
      --  MageNugz_SaveFrame_Position();

    elseif (event == "PLAYER_REGEN_DISABLED") then
        incombat = 1;
    elseif (event == "CVAR_UPDATE") then
        combatTextCvar = GetCVar("enableCombatText")
    elseif (event == "PLAYER_ENTERING_WORLD") then
        MageNugz_SaveFrame_Position();
    elseif (event == "COMBAT_LOG_EVENT_UNFILTERED")then
        local timestamp, event1, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName = CombatLogGetCurrentEventInfo()
        local arg, spellName, spellSchool, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = select(12, CombatLogGetCurrentEventInfo())

        -- if((sourceName == UnitName("player")) or (destName == UnitName("player"))) then
        --  DEFAULT_CHAT_FRAME:AddMessage(arg.." "..event1.." "..spellName);
        -- end

        if (event1 == "SPELL_CAST_SUCCESS") and (sourceName == UnitName("pet"))then
            if(arg == 33395)then -- Water Elly Freeze
                freezeId, _, _, _, _, _, _, _, _ = GetSpellInfo(33395);
                MNcooldownMonitor(freezeId, 25, "Interface\\Icons\\spell_frost_frostnova")
            elseif(arg == 135029)then -- Water Elly Water Jet
                freezeId, _, _, _, _, _, _, _, _ = GetSpellInfo(135029);
                MNcooldownMonitor(freezeId, 25, "Interface\\Icons\\spell_frost_chillingblast")
            end
        elseif (event1 == "SPELL_SUMMON") and (sourceName == UnitName("player")) then
            if (arg == 113724) then -- ring of frost
                ringfrostID, _, _, _, _, _, _, _, _ = GetSpellInfo(113724);
                MNcooldownMonitor(ringfrostID, 45, "Interface\\Icons\\spell_frost_frozencore")
            end
        elseif (event1 == "SPELL_CAST_SUCCESS") and (sourceName == UnitName("player"))then
            MnCdMonSpellCastSuccess(arg, sourceName, destName);
        elseif (event1 == "SPELL_AURA_REMOVED") and (sourceName == UnitName("player")) then
            MnCdMonSpellAuraRemoved(arg, sourceName, destName);
        elseif (event1 == "SPELL_AURA_APPLIED") and (sourceName == UnitName("player")) then
            MnCdMonSpellAuraAppliedSource(arg, sourceName, destName);
        end
     end
end

--============================================================================--
--                      Spell Cast Success
--============================================================================--

function MnCdMonSpellCastSuccess(arg, sourceName, destName)
    if (arg == 111264) then -- ice ward
        iceWardID, _, _, _, _, _, _, _, _ = GetSpellInfo(111264);
        MNcooldownMonitor(iceWardID, 20, "Interface\\Icons\\spell_frost_frostward")
    elseif (arg == 205030) then -- frozen touch
        frozenID, _, _, _, _, _, _, _, _ = GetSpellInfo(205030);
        MNcooldownMonitor(frozenID, 30, "Interface\\Icons\\ability_mage_coldasice")
    elseif (arg == 153595) then -- comet storm
        iceWardID, _, _, _, _, _, _, _, _ = GetSpellInfo(153595);
        MNcooldownMonitor(iceWardID, 20, "Interface\\Icons\\spell_mage_cometstorm")
    elseif (arg == 2120) then -- flamestrike
        flamestrikeID, _, _, _, _, _, _, _, _ = GetSpellInfo(2120);
        MNcooldownMonitor(flamestrikeID, 12, "Interface\\Icons\\spell_fire_selfdestruct")
    elseif (arg == 12472) then --icy veins
        icyveinsId, _, _, _, _, _, _, _, _ = GetSpellInfo(12472);
        MNcooldownMonitor(icyveinsId, 180, "Interface\\Icons\\Spell_frost_coldhearted");
    elseif (arg == 1953) then -- blink
        blinkId, _, _, _, _, _, _, _, _ = GetSpellInfo(1953);
        MNcooldownMonitor(blinkId, 15, "Interface\\Icons\\spell_arcane_blink")
    elseif (arg == 11426) then -- ice barrier
        start, duration, enabled = GetSpellCooldown(11426);
        icebarrierId, _, _, _, _, _, _, _, _ = GetSpellInfo(11426);
        MNcooldownMonitor(icebarrierId, 24, "Interface\\Icons\\spell_ice_lament")
    elseif (arg == 1463) then -- mana shield
        manashieldId, _, _, _, _, _, _, _, _ = GetSpellInfo(1463);
        MNcooldownMonitor(manashieldId, 12, "Interface\\Icons\\spell_shadow_detectlesserinvisibility")
    elseif (arg == 44457) then -- living bomb
        lbId, _, _, _, _, _, _, _, _ = GetSpellInfo(44457);
        MNcooldownMonitor(lbId, 12, "Interface\\Icons\\ability_mage_livingbomb")
    elseif (arg == 543) then -- mage ward
        wardId, _, _, _, _, _, _, _, _ = GetSpellInfo(543);
        MNcooldownMonitor(wardId, 30, "Interface\\Icons\\spell_fire_twilightfireward")
    elseif (arg == 122) then -- frost nova
        frostnovaId, _, _, _, _, _, _, _, _ = GetSpellInfo(122);
        MNcooldownMonitor(frostnovaId, 25, "Interface\\Icons\\spell_frost_frostnova")
    elseif (arg == 120) then -- cone of cold
        coneofcoldId, _, _, _, _, _, _, _, _ = GetSpellInfo(120);
        MNcooldownMonitor(coneofcoldId, 10, "Interface\\Icons\\spell_frost_glacier")
    elseif (arg == 84714) then -- frozen orb
        frozenOrbID, _, _, _, _, _, _, _, _ = GetSpellInfo(84714);
        MNcooldownMonitor(frozenOrbID, 60, "Interface\\Icons\\spell_frost_frozenorb")
    elseif (arg == 153626) then -- arcane orb
        arcaneOrbId, _, _, _, _, _, _, _, _ = GetSpellInfo(153626);
        MNcooldownMonitor(arcaneOrbId, 15, "Interface\\Icons\\spell_mage_arcaneorb")
    elseif (arg == 152087) then -- prismatic crystal
        prismaticCrystalId, _, _, _, _, _, _, _, _ = GetSpellInfo(152087);
        MNcooldownMonitor(prismaticCrystalId, 90, "Interface\\Icons\\spell_mage_focusingcrystal")
    elseif (arg == 45438) then -- Ice Block
        local ibstart, ibduration, ibenabled = GetSpellCooldown(78674);
        local ibTime = RoundOne(ibstart + ibduration - GetTime())
        iceblockId, _, _, _, _, _, _, _, _ = GetSpellInfo(45438);
        MNcooldownMonitor(iceblockId, ibTime, "Interface\\Icons\\spell_frost_frost")
    elseif (arg == 82731) then -- Flame Orb
        flameOrbId, _, _, _, _, _, _, _, _ = GetSpellInfo(82731);
        MNcooldownMonitor(flameOrbId, 60, "Interface\\Icons\\spell_mage_flameorb")
    elseif (arg == 190319) then -- Combustion
        combustionId, _, _, _, _, _, _, _, _ = GetSpellInfo(190319);
        MNcooldownMonitor(combustionId, 120, "Interface\\Icons\\spell_fire_sealoffire")
    elseif (arg == 31661) then -- Dragons Breath
        dragonsbreathId, _, _, _, _, _, _, _, _ = GetSpellInfo(31661);
        MNcooldownMonitor(dragonsbreathId, 20, "Interface\\Icons\\inv_misc_head_dragon_01")
    elseif (arg == 157981) then -- blastwave
        blastwaveId, _, _, _, _, _, _, _, _ = GetSpellInfo(157981);
        MNcooldownMonitor(blastwaveId, 25, "Interface\\Icons\\spell_holy_excorcism_02")
    elseif (arg == 66) then -- invisibility
        invisId, _, _, _, _, _, _, _, _ = GetSpellInfo(66);
        MNcooldownMonitor(invisId, 300, "Interface\\Icons\\ability_mage_invisibility")
    elseif (arg == 110959) then -- greater invisibility
        invisId, _, _, _, _, _, _, _, _ = GetSpellInfo(110959);
        MNcooldownMonitor(invisId, 120, "Interface\\Icons\\ability_mage_greaterinvisibility")
    elseif (arg == 12051) then -- evocation
        invisId, _, _, _, _, _, _, _, _ = GetSpellInfo(12051);
        MNcooldownMonitor(invisId, 90, "Interface\\Icons\\spell_nature_purge")
    elseif (arg == 44572) then -- deep freeze
        deepfreezeId, _, _, _, _, _, _, _, _ = GetSpellInfo(44572);
        MNcooldownMonitor(deepfreezeId, 30, "Interface\\Icons\\ability_mage_deepfreeze")
    elseif (arg == 116014) then -- rune of power
        runeId, _, _, _, _, _, _, _, _ = GetSpellInfo(116014);
        MNcooldownMonitor(runeId, 30, "Interface\\Icons\\spell_mage_runeofpower")
    elseif (arg == 157980) then -- supernova
        superNovaId, _, _, _, _, _, _, _, _ = GetSpellInfo(157980);
        MNcooldownMonitor(superNovaId, 25, "Interface\\Icons\\spell_mage_supernova")
    elseif (arg == 205032) then -- charged up
        chargedId, _, _, _, _, _, _, _, _ = GetSpellInfo(205032);
        MNcooldownMonitor(chargedId, 40, "Interface\\Icons\\ability_thunderking_overcharge")
    elseif (arg == 26297) then -- berserking
        chargedId, _, _, _, _, _, _, _, _ = GetSpellInfo(26297);
        MNcooldownMonitor(chargedId, 180, "Interface\\Icons\\racial_troll_berserk")
    elseif (arg == 153561) then -- meteor
        chargedId, _, _, _, _, _, _, _, _ = GetSpellInfo(153561);
        MNcooldownMonitor(chargedId, 45, "Interface\\Icons\\spell_mage_meteor")
    elseif (arg == 108839) then -- ice floes
        chargedId, _, _, _, _, _, _, _, _ = GetSpellInfo(108839);
        MNcooldownMonitor(chargedId, 20, "Interface\\Icons\\spell_mage_iceflows")
    elseif (arg == 205029) then -- flame on
        chargedId, _, _, _, _, _, _, _, _ = GetSpellInfo(205029);
        MNcooldownMonitor(chargedId, 40, "Interface\\Icons\\inv_helm_circlet_firelands_d_01")
    elseif (arg == 198929) then -- cinderstorm
        spellName, _, _, _, _, _, _, _, _ = GetSpellInfo(198929);
        MNcooldownMonitor(spellName, 9, "Interface\\Icons\\spell_fire_flare")
    elseif (arg == 12042) then -- arcane power
        spellName, _, _, _, _, _, _, _, _ = GetSpellInfo(12042);
        MNcooldownMonitor(spellName, 90, "Interface\\Icons\\spell_nature_lightning");
    elseif (arg == 2139) then -- Counterspell
        spellName, _, _, _, _, _, _, _, _ = GetSpellInfo(2139);
        MNcooldownMonitor(spellName, 24, "Interface\\Icons\\spell_frost_iceshock")
    elseif (arg == 376103) then -- Radiant Spark
        spellName, _, _, _, _, _, _, _, _ = GetSpellInfo(307443);
        MNcooldownMonitor(spellName, 30, "Interface\\Icons\\ability_bastion_mage")
    elseif (arg == 321507) then -- Touch of the Magi
        spellName, _, _, _, _, _, _, _, _ = GetSpellInfo(321507);
        MNcooldownMonitor(spellName, 45, "Interface\\Icons\\ability_mage_netherwindpresence")
    elseif (arg == 365350) then -- Arcane Surge
        spellName, _, _, _, _, _, _, _, _ = GetSpellInfo(365350);
        MNcooldownMonitor(spellName, 90, "Interface\\Icons\\ability_mage_arcanesurge")
    end
end

--============================================================================--
--                      Spell Aura Removed
--============================================================================--

function MnCdMonSpellAuraRemoved(arg, sourceName, destName)
    if(arg == 110909) then -- alter time
        start, duration, enabled = GetSpellCooldown(108978);
        alterTimeId, _, _, _, _, _, _, _, _ = GetSpellInfo(108978);
        MNcooldownMonitor(alterTimeId, RoundZero(start + duration - GetTime()), "Interface\\Icons\\spell_mage_altertime")
    elseif(arg == 208141) then -- Ray of Frost
        local start, duration, enabled = GetSpellCooldown(205021);
        local coolDownTime = RoundOne(start + duration - GetTime());
        if(coolDownTime ~= nil) and (coolDownTime > 0)then
          rayId, _, _, _, _, _, _, _, _ = GetSpellInfo(205021);
          MNcooldownMonitor(rayId, 60, "Interface\\Icons\\spell_frost_chillingblast")
        end
    elseif (arg == 205025) then -- presence of mind
        start, duration, enabled = GetSpellCooldown(205025);
        pomId, _, _, _, _, _, _, _, _ = GetSpellInfo(205025);
        MNcooldownMonitor(pomId, RoundZero(start + duration - GetTime()), "Interface\\Icons\\spell_nature_enchantarmor");
    elseif (arg == 48505) then
        start, duration, enabled = GetSpellCooldown(48505);
        starFallId, _, _, _, _, _, _, _, _ = GetSpellInfo(48505);
        MNcooldownMonitor(starFallId, RoundZero(start + duration - GetTime()), "Interface\\Icons\\ability_druid_starfall");
    elseif (arg == 212653) then -- shimmer
        -- TODO: uses charges
        blinkId, _, _, _, _, _, _, _, _ = GetSpellInfo(212653);
        MNcooldownMonitor(blinkId, 15, "Interface\\Icons\\spell_arcane_blink");
    elseif (arg == 11426) then
        start, duration, enabled = GetSpellCooldown(11426);
        icebarrierId, _, _, _, _, _, _, _, _ = GetSpellInfo(11426);
        MNcooldownMonitor(icebarrierId, RoundZero(start + duration - GetTime()), "Interface\\Icons\\spell_ice_lament");
    end
end
--============================================================================--
--                      Spell Aura Applied Source
--============================================================================--

function MnCdMonSpellAuraAppliedSource(arg, sourceName, destName)
    if (arg == 55342) then -- mirror image
      mirrorImageId, _, _, _, _, _, _, _, _ = GetSpellInfo(55342);
      MNcooldownMonitor(mirrorImageId, 120, "Interface\\Icons\\spell_magic_lesserinvisibilty")
    elseif (arg == 157997) then -- mirror image
      mirrorImageId, _, _, _, _, _, _, _, _ = GetSpellInfo(157997);
      MNcooldownMonitor(mirrorImageId, 25, "Interface\\Icons\\spell_mage_icenova")
    end
end
--============================================================================--
--                          Cooldown Monitor
--============================================================================--

function MNcooldownMonitor(name, expiretime, texture)
  if(has_value(MageNuggetsClassicCoolDownMon.removedSpells, name) == false) then
    if(MageNugCD1_Frame_Bar:GetValue() < 1)then
        MageNugCD1_Frame_Bar:SetMinMaxValues(0,expiretime)
        MageNugCD1_Frame_Text:SetText(name)
        MageNugCD1_Frame_Text2:SetText("!")
        MageNugCD1_Frame_Texture:SetTexture(texture)
        MageNugCD1_Frame:Show()
        MageNugCD_Frame:Show()
    elseif(MageNugCD2_Frame_Bar:GetValue() < 1)then
        MageNugCD2_Frame_Bar:SetMinMaxValues(0,expiretime)
        MageNugCD2_Frame_Text:SetText(name)
        MageNugCD2_Frame_Text2:SetText("!")
        MageNugCD2_Frame_Texture:SetTexture(texture)
        MageNugCD2_Frame:Show()
    elseif(MageNugCD3_Frame_Bar:GetValue() < 1)then
        MageNugCD3_Frame_Bar:SetMinMaxValues(0,expiretime)
        MageNugCD3_Frame_Text:SetText(name)
        MageNugCD3_Frame_Text2:SetText("!")
        MageNugCD3_Frame_Texture:SetTexture(texture)
        MageNugCD3_Frame:Show()
    elseif(MageNugCD4_Frame_Bar:GetValue() < 1)then
        MageNugCD4_Frame_Bar:SetMinMaxValues(0,expiretime)
        MageNugCD4_Frame_Text:SetText(name)
        MageNugCD4_Frame_Text2:SetText("!")
        MageNugCD4_Frame_Texture:SetTexture(texture)
        MageNugCD4_Frame:Show()
    elseif(MageNugCD5_Frame_Bar:GetValue() < 1)then
        MageNugCD5_Frame_Bar:SetMinMaxValues(0,expiretime)
        MageNugCD5_Frame_Text:SetText(name)
        MageNugCD5_Frame_Text2:SetText("!")
        MageNugCD5_Frame_Texture:SetTexture(texture)
        MageNugCD5_Frame:Show()
    elseif(MageNugCD6_Frame_Bar:GetValue() < 1)then
        MageNugCD6_Frame_Bar:SetMinMaxValues(0,expiretime)
        MageNugCD6_Frame_Text:SetText(name)
        MageNugCD6_Frame_Text2:SetText("!")
        MageNugCD6_Frame_Texture:SetTexture(texture)
        MageNugCD6_Frame:Show()
    end
  end
end
--
function MageNuggetsClassicCD1_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate >= 0.1) then
        local start, duration, enabled = GetSpellCooldown(MageNugCD1_Frame_Text:GetText());
        if(start ~= nil) and (duration ~= nil) then
            local timeleft = RoundZero(start + duration - GetTime())
            MageNugCD1_Frame_Bar:SetValue(timeleft);
            MageNugCD1_Frame_Text2:SetText(timeleft.."s")
            if (timeleft <= 0) then
                MageNugCD1_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end
end
--
function MageNuggetsClassicCD2_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate >= 0.1) then
        local start, duration, enabled = GetSpellCooldown(MageNugCD2_Frame_Text:GetText());
        if(start ~= nil) and (duration ~= nil) then
            local timeleft = RoundZero(start + duration - GetTime())
            MageNugCD2_Frame_Bar:SetValue(timeleft);
            MageNugCD2_Frame_Text2:SetText(timeleft.."s")
            if (timeleft <= 0) then
                MageNugCD2_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end
end
--
function MageNuggetsClassicCD3_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate >= 0.1) then
        local start, duration, enabled = GetSpellCooldown(MageNugCD3_Frame_Text:GetText());
        if(start ~= nil) and (duration ~= nil) then
            local timeleft = RoundZero(start + duration - GetTime())
            MageNugCD3_Frame_Bar:SetValue(timeleft);
            MageNugCD3_Frame_Text2:SetText(timeleft.."s")
            if (timeleft <= 0) then
                MageNugCD3_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end
end
--
function MageNuggetsClassicCD4_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate >= 0.1) then
        local start, duration, enabled = GetSpellCooldown(MageNugCD4_Frame_Text:GetText());
        if(start ~= nil) and (duration ~= nil) then
            local timeleft = RoundZero(start + duration - GetTime())
            MageNugCD4_Frame_Bar:SetValue(timeleft);
            MageNugCD4_Frame_Text2:SetText(timeleft.."s")
            if (timeleft <= 0) then
                MageNugCD4_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end
end
--
function MageNuggetsClassicCD5_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate >= 0.1) then
        local start, duration, enabled = GetSpellCooldown(MageNugCD5_Frame_Text:GetText());
        if(start ~= nil) and (duration ~= nil) then
            local timeleft = RoundZero(start + duration - GetTime())
            MageNugCD5_Frame_Bar:SetValue(timeleft);
            MageNugCD5_Frame_Text2:SetText(timeleft.."s")
            if (timeleft <= 0) then
                MageNugCD5_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end
end
--
function MageNuggetsClassicCD6_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate >= 0.1) then
        local start, duration, enabled = GetSpellCooldown(MageNugCD6_Frame_Text:GetText());
        if(start ~= nil) and (duration ~= nil) then
            local timeleft = RoundZero(start + duration - GetTime())
            MageNugCD6_Frame_Bar:SetValue(timeleft);
            MageNugCD6_Frame_Text2:SetText(timeleft.."s")
            if (timeleft <= 0) then
                MageNugCD6_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end
end
--
function has_value (tab, val)
    for index, value in ipairs (tab) do
        if(value == val) then
            return true
        end
    end
    return false
end
--
function find_index(spellName)
  for index, value in pairs(MageNuggetsClassicCoolDownMon.removedSpells) do
    if(value == spellName) then
      return index;
    end
  end
  return nil;
end
--
function printIgnoreList()
  DEFAULT_CHAT_FRAME:AddMessage("------ Ignored Spells ------");
  for i, name in ipairs(MageNuggetsClassicCoolDownMon.removedSpells) do
      DEFAULT_CHAT_FRAME:AddMessage(name);
  end
end
--
function addSpellToIgnoreList(spellName)
  local name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(spellName);
  if(name ~= nil) then
    if(MageNuggetsClassicCoolDownMon.removedSpells == nil) then
      MageNuggetsClassicCoolDownMon.removedSpells = {spellName}
    else
      if(has_value(MageNuggetsClassicCoolDownMon.removedSpells, spellName) == false) then
        DEFAULT_CHAT_FRAME:AddMessage("Adding "..spellName.." To Ignore List");
        table.insert(MageNuggetsClassicCoolDownMon.removedSpells,spellName);
      end
    end
  else
    DEFAULT_CHAT_FRAME:AddMessage("Spell Not Found, Check Your Casing and Spelling.");
  end
end
--
function removeSpellFromIgnoreList(spellName)
  local spellIndex = find_index(spellName);
  if(spellIndex ~= nil) then
    DEFAULT_CHAT_FRAME:AddMessage("Removing "..spellName.." From Ignore List");
    table.remove(MageNuggetsClassicCoolDownMon.removedSpells,spellIndex);
  else
    DEFAULT_CHAT_FRAME:AddMessage("Spell Not Found, Check Your Casing and Spelling.");
  end
end
--
function MNcooldownSlider()
    local tempInt = MageNugCDOptionsFrame_SizeSlider:GetValue()

    if not MageNugCDOptionsFrame_SizeSlider._onsetting then
        MageNugCDOptionsFrame_SizeSlider._onsetting = true
        MageNugCDOptionsFrame_SizeSlider:SetValue(MageNugCDOptionsFrame_SizeSlider:GetValue())
        tempInt = MageNugCDOptionsFrame_SizeSlider:GetValue()
        MageNugCDOptionsFrame_SizeSlider._onsetting = false
    else return end

    if (tempInt == 0) then
        MageNugCD_Frame:SetScale(0.7);
        MageNuggetsClassicCoolDownMon.cooldownSize = 0;
    end
    if (tempInt == 1) then
        MageNugCD_Frame:SetScale(0.8);
        MageNuggetsClassicCoolDownMon.cooldownSize = 1;
    end
    if (tempInt == 2) then
        MageNugCD_Frame:SetScale(0.9);
        MageNuggetsClassicCoolDownMon.cooldownSize = 2;
    end
    if (tempInt == 3) then
        MageNugCD_Frame:SetScale(1.0);
        MageNuggetsClassicCoolDownMon.cooldownSize = 3;
    end
    if (tempInt == 4) then
        MageNugCD_Frame:SetScale(1.1);
        MageNuggetsClassicCoolDownMon.cooldownSize = 4;
    end
    if (tempInt == 5) then
        MageNugCD_Frame:SetScale(1.2);
        MageNuggetsClassicCoolDownMon.cooldownSize = 5;
    end
    if (tempInt == 6) then
        MageNugCD_Frame:SetScale(1.3);
        MageNuggetsClassicCoolDownMon.cooldownSize = 6;
    end
    if (tempInt == 7) then
        MageNugCD_Frame:SetScale(1.4);
        MageNuggetsClassicCoolDownMon.cooldownSize = 7;
    end
    if (tempInt == 8) then
        MageNugCD_Frame:SetScale(1.6);
        MageNuggetsClassicCoolDownMon.cooldownSize = 8;
    end
    if (tempInt == 9) then
        MageNugCD_Frame:SetScale(1.8);
        MageNuggetsClassicCoolDownMon.cooldownSize = 9;
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
