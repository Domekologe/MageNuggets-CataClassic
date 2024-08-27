-- Mage Nuggets Classic Stat Monitor - B-Buck (Bbuck of Eredar)

local currentStatColor = 0;
local statMonitorLoadTimer = 0;
local spellPowerLimitBreak = false;
local critLimitBreak = false;

function MageNuggetsClassicSP_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
 if (self.TimeSinceLastUpdate > 0.3) then

    local spellpower = GetSpellBonusDamage(3);
    local attackpower, posBuff, negBuff = UnitAttackPower("player");
    local crit = roundStat(GetSpellCritChance(3));
    local haste = roundStat(UnitSpellHaste("player"));
    local mastery = roundStat(GetMastery());
    local hit = roundStat(GetCombatRatingBonus(CR_HIT_SPELL));
    local versatility = roundStat(GetCombatRatingBonus(29));
    local base, stat, posBuff, negBuff = UnitStat("player",3);
    local spirit = stat;
    local baseRegen, castingRegen = GetManaRegen()
    local manaregen = roundZero(castingRegen*5);
    local armorBase, effectiveArmor, armor, posBuff, negBuff = UnitArmor("player");
    local statCount = 0;
    local readout = {};
    local stats = {};
    local bonusSpellDamage = 0;

    local i = 1;
    local buffName, rank, _, count, _, _, expirationTime, _, _, _, spellId = UnitAura("player", i, "HELPFUL");
    while buffName do
        if(spellId == 116014) then -- Rune of Power
            bonusSpellDamage = 15;
        end
        if(spellId == 116267) then -- Incanter's Flow
            bonusSpellDamage = count * 4;
        end
        i = i + 1;
        buffName, rank, _, count, _, _, expirationTime, _, _, _, spellId = UnitAura("player", i, "HELPFUL");
    end

    if(MageNuggetsClassicStatMonitor.spellpower == true)then
        statCount = statCount + 1;
        readout[statCount] = "SPower";
        if(bonusSpellDamage > 0)then
            spellpower = spellpower * (1+(bonusSpellDamage * 0.01));
        end
        stats[statCount] = roundZero(spellpower);
    end
    if(MageNuggetsClassicStatMonitor.attackpower == true)then
        statCount = statCount + 1;
        readout[statCount] = "APower";
        stats[statCount] = roundZero(attackpower);
    end
    if(MageNuggetsClassicStatMonitor.crit == true)then
        statCount = statCount + 1;
        readout[statCount] = "Crit";
        stats[statCount] = crit;
    end
    if(MageNuggetsClassicStatMonitor.haste == true)then
        statCount = statCount + 1;
        readout[statCount] = "Haste";
        stats[statCount] = haste;
    end
	
    if(MageNuggetsClassicStatMonitor.mastery == true)then
        statCount = statCount + 1;
        readout[statCount] = "Mastery";
        stats[statCount] = mastery;
    end
	
    if(MageNuggetsClassicStatMonitor.hit == true)then
        statCount = statCount + 1;
        readout[statCount] = "Hit";
        stats[statCount] = hit;
    end
	
    if(MageNuggetsClassicStatMonitor.versatility == true)then
        statCount = statCount + 1;
        readout[statCount] = "Versatil";
        stats[statCount] = versatility;
    end
    if(MageNuggetsClassicStatMonitor.spirit == true)then
        statCount = statCount + 1;
        readout[statCount] = "Spirit";
        stats[statCount] = spirit;
    end
    if(MageNuggetsClassicStatMonitor.manaregen == true)then
        statCount = statCount + 1;
        readout[statCount] = "Regen";
        stats[statCount] = manaregen;
    end
    if(MageNuggetsClassicStatMonitor.armor == true)then
        statCount = statCount + 1;
        readout[statCount] = "Armor";
        stats[statCount] = roundStat(armor);
    end
    if(statCount > 0) then
        local i = 1;
        while(statCount >= i) do
            _G["MageNugSP_FrameText"..i]:SetText(readout[i]);
            _G["MageNugSP_FrameValueText"..i]:SetText(stats[i]);
            i = i + 1;
        end
        local i = 11;
        while(statCount < i) do
           _G["MageNugSP_FrameText"..i]:SetText("");
           _G["MageNugSP_FrameValueText"..i]:SetText("");
            i = i - 1;
        end
    else
        local i = 10;
        while(statCount < i) do
           _G["MageNugSP_FrameText"..i]:SetText("");
           _G["MageNugSP_FrameValueText"..i]:SetText("");
            i = i - 1;
        end
    end
    for k in pairs (readout) do
        readout[k] = nil
    end
    for j in pairs (stats) do
        stats[j] = nil
    end
    if statMonitorLoadTimer < 4 then
        statMonitorLoadTimer = statMonitorLoadTimer + 1;
        setStatMonitorHeight(statCount);
        dressStatMonitorText();
    end
    statCount = 0;

    if(spellpower > MageNuggetsClassicStatMonitor.baseSpellPower) then
      spellPowerLimitBreak = true;
    else
      spellPowerLimitBreak = false;
    end

    if(MageNuggetsClassicStatMonitor.limitBreakToggle == true) then
      MageNuggetsClassicBuff_OnUpdate();
    end
    self.TimeSinceLastUpdate = 0;
   end
end

function setStatMonitorHeight(statCount)
    if(statCount==0)then
        MageNugSP_Frame:SetHeight(20);
    elseif(statCount==1)then
        MageNugSP_Frame:SetHeight(20);
    elseif(statCount==2)then
        MageNugSP_Frame:SetHeight(30);
    elseif(statCount==3)then
        MageNugSP_Frame:SetHeight(40);
    elseif(statCount==4)then
        MageNugSP_Frame:SetHeight(49);
    elseif(statCount==5)then
        MageNugSP_Frame:SetHeight(59);
    elseif(statCount==6)then
        MageNugSP_Frame:SetHeight(69);
    elseif(statCount==7)then
        MageNugSP_Frame:SetHeight(79);
    elseif(statCount==8)then
        MageNugSP_Frame:SetHeight(89);
    elseif(statCount==9)then
        MageNugSP_Frame:SetHeight(99);
    elseif(statCount==10)then
        MageNugSP_Frame:SetHeight(110);
    elseif(statCount==11)then
        MageNugSP_Frame:SetHeight(120);
    end
end

function MageNuggetsClassicStatMonitorToggle(statType)
    if(statType == "spellpower") then
        if (MageNuggetsClassicStatMonitor.spellpower == false) then
            MageNuggetsClassicStatMonitor.spellpower = true;
        else
            MageNuggetsClassicStatMonitor.spellpower = false;
        end
    elseif(statType == "attackpower") then
        if (MageNuggetsClassicStatMonitor.attackpower == false) then
            MageNuggetsClassicStatMonitor.attackpower = true;
        else
            MageNuggetsClassicStatMonitor.attackpower = false;
        end
    elseif(statType == "crit") then
        if (MageNuggetsClassicStatMonitor.crit == false) then
            MageNuggetsClassicStatMonitor.crit = true;
        else
            MageNuggetsClassicStatMonitor.crit = false;
        end
    elseif(statType == "haste") then
        if (MageNuggetsClassicStatMonitor.haste == false) then
            MageNuggetsClassicStatMonitor.haste = true;
        else
            MageNuggetsClassicStatMonitor.haste = false;
        end
    elseif(statType == "mastery") then
        if (MageNuggetsClassicStatMonitor.mastery == false) then
            MageNuggetsClassicStatMonitor.mastery = true;
        else
            MageNuggetsClassicStatMonitor.mastery = false;
        end
	
    elseif(statType == "hit") then
        if (MageNuggetsClassicStatMonitor.hit == false) then
            MageNuggetsClassicStatMonitor.hit = true;
        else
            MageNuggetsClassicStatMonitor.hit = false;
        end
		
    elseif(statType == "versatility") then
        if (MageNuggetsClassicStatMonitor.versatility == false) then
            MageNuggetsClassicStatMonitor.versatility = true;
        else
            MageNuggetsClassicStatMonitor.versatility = false;
        end
    elseif(statType == "spirit") then
        if (MageNuggetsClassicStatMonitor.spirit == false) then
            MageNuggetsClassicStatMonitor.spirit = true;
        else
            MageNuggetsClassicStatMonitor.spirit = false;
        end
    elseif(statType == "manaregen") then
        if (MageNuggetsClassicStatMonitor.manaregen == false) then
            MageNuggetsClassicStatMonitor.manaregen = true;
        else
            MageNuggetsClassicStatMonitor.manaregen = false;
        end
    elseif(statType == "armor") then
        if (MageNuggetsClassicStatMonitor.armor == false) then
            MageNuggetsClassicStatMonitor.armor = true;
        else
            MageNuggetsClassicStatMonitor.armor = false;
        end
    end
    setStatMonitorHeight(dressStatMonitorText());
    dressStatMonitorText();
end

function roundStat(value)
    return math.floor(value*math.pow(10,2)+0.5) / math.pow(10,2)
end

function roundZero(inputNum)
    return math.floor(inputNum*math.pow(10,0)+0.5) / math.pow(10,0)
end

function setStatMonitorStats()
    if (MageNuggetsClassicStatMonitor.spellpower == nil)then
        MageNuggetsClassicStatMonitor.spellpower = true
    end
    if (MageNuggetsClassicStatMonitor.spellpower == true) then
        MageNugSP_SpellPowerCheckButton:SetChecked(true);
    else
        MageNugSP_SpellPowerCheckButton:SetChecked(false);
    end

    if (MageNuggetsClassicStatMonitor.attackpower == nil)then
        MageNuggetsClassicStatMonitor.attackpower = true
    end
    if (MageNuggetsClassicStatMonitor.attackpower == true) then
        MageNugSP_AttackPowerCheckButton:SetChecked(true);
    else
        MageNugSP_AttackPowerCheckButton:SetChecked(false);
    end

    if (MageNuggetsClassicStatMonitor.crit == nil)then
        MageNuggetsClassicStatMonitor.crit = true
    end
    if (MageNuggetsClassicStatMonitor.crit == true) then
        MageNugSP_CritCheckButton:SetChecked(true);
    else
        MageNugSP_CritCheckButton:SetChecked(false);
    end

    if (MageNuggetsClassicStatMonitor.haste == nil)then
        MageNuggetsClassicStatMonitor.haste = true
    end
    if (MageNuggetsClassicStatMonitor.haste == true) then
        MageNugSP_HasteCheckButton:SetChecked(true);
    else
        MageNugSP_HasteCheckButton:SetChecked(false);
    end

    if (MageNuggetsClassicStatMonitor.mastery == nil)then
        MageNuggetsClassicStatMonitor.mastery = true
    end
    if (MageNuggetsClassicStatMonitor.mastery == true) then
        MageNugSP_MasteryCheckButton:SetChecked(true);
    else
        MageNugSP_MasteryCheckButton:SetChecked(false);
    end

    if (MageNuggetsClassicStatMonitor.hit == nil)then
        MageNuggetsClassicStatMonitor.hit = true
    end
    if (MageNuggetsClassicStatMonitor.hit == true) then
        MageNugSP_HitCheckButton:SetChecked(true);
    else
        MageNugSP_HitCheckButton:SetChecked(false);
    end

    if (MageNuggetsClassicStatMonitor.versatility == nil)then
        MageNuggetsClassicStatMonitor.versatility = true
    end
    if (MageNuggetsClassicStatMonitor.versatility == true) then
        MageNugSP_VersatilityCheckButton:SetChecked(true);
    else
        MageNugSP_VersatilityCheckButton:SetChecked(false);
    end

    if (MageNuggetsClassicStatMonitor.spirit == nil)then
        MageNuggetsClassicStatMonitor.spirit = true
    end
    if (MageNuggetsClassicStatMonitor.spirit == true) then
        MageNugSP_SpiritCheckButton:SetChecked(true);
    else
        MageNugSP_SpiritCheckButton:SetChecked(false);
    end

    if (MageNuggetsClassicStatMonitor.manaregen == nil)then
        MageNuggetsClassicStatMonitor.manaregen = true
    end
    if (MageNuggetsClassicStatMonitor.manaregen == true) then
        MageNugSP_ManaRegenCheckButton:SetChecked(true);
    else
        MageNugSP_ManaRegenCheckButton:SetChecked(false);
    end

    if (MageNuggetsClassicStatMonitor.armor == nil)then
        MageNuggetsClassicStatMonitor.armor = true
    end
    if (MageNuggetsClassicStatMonitor.armor == true) then
        MageNugSP_ArmorCheckButton:SetChecked(true);
    else
        MageNugSP_ArmorCheckButton:SetChecked(false);
    end
end

function MageNuggetsClassicBuff_OnUpdate(self, elapsed)
    local lusted = false;
    local i = 1;
    local buffName, rank, _, count, _, _, expirationTime, _, _, _, spellId = UnitAura("player", i, "HELPFUL");
    while buffName do
        if(spellId == 80353) or (spellId == 102351) or (spellId == 2825) or (spellId == 32182) then -- Timewarp
            lusted = true;
        end
        i = i + 1;
        buffName, rank, _, count, _, _, expirationTime, _, _, _, spellId = UnitAura("player", i, "HELPFUL");
    end

    local hasteIndex = getStatIndex("Haste");
    local spIndex = getStatIndex("SPower");
    --local base, stat, posBuff, negBuff = UnitStat("player", 4);
    --DEFAULT_CHAT_FRAME:AddMessage(base.."   "..posBuff.."  "..stat.."  "..negBuff);
    local rRoll = (math.random (10) * 0.1);
    local gRoll = (math.random (10) * 0.1);
    local bRoll = (math.random (10) * 0.1);

    if(lusted == true) then
      if(hasteIndex ~= 0)then
        _G["MageNugSP_FrameValueText"..hasteIndex]:SetTextColor(rRoll, gRoll, bRoll);
      end
    else
      if(hasteIndex ~= 0)then
        _G["MageNugSP_FrameValueText"..hasteIndex]:SetTextColor(MageNuggetsClassicStatMonitor.hasteValueR,MageNuggetsClassicStatMonitor.hasteValueG,MageNuggetsClassicStatMonitor.hasteValueB,1);
      end
    end

    if(spellPowerLimitBreak == true) then
      if(spIndex ~= 0)then
        _G["MageNugSP_FrameValueText"..spIndex]:SetTextColor(rRoll, gRoll, bRoll);
      end
    else
      if(spIndex ~= 0)then
        _G["MageNugSP_FrameValueText"..spIndex]:SetTextColor(MageNuggetsClassicStatMonitor.spellpowerValueR,MageNuggetsClassicStatMonitor.spellpowerValueG,MageNuggetsClassicStatMonitor.spellpowerValueB,1);
      end
    end
end

function getStatIndex(stat)
  local hasteIndex = 0;
  local i = 1;
  while i < 11 do
    local statText = _G["MageNugSP_FrameText"..i]:GetText();
    if (statText == stat) then
      return i;
    end
    i = i + 1;
  end
  return 0;
end

function dressStatMonitorText()
    local statCount = 0;
    if(MageNuggetsClassicStatMonitor.spellpower == true) then
        statCount = statCount + 1;
        _G["MageNugSP_FrameText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.spellpowerR,MageNuggetsClassicStatMonitor.spellpowerG,MageNuggetsClassicStatMonitor.spellpowerB,1);
        _G["MageNugSP_FrameValueText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.spellpowerValueR,MageNuggetsClassicStatMonitor.spellpowerValueG,MageNuggetsClassicStatMonitor.spellpowerValueB,1);
    end
    if(MageNuggetsClassicStatMonitor.attackpower == true) then
        statCount = statCount + 1;
        _G["MageNugSP_FrameText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.attackpowerR,MageNuggetsClassicStatMonitor.attackpowerG,MageNuggetsClassicStatMonitor.attackpowerB,1);
        _G["MageNugSP_FrameValueText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.attackpowerValueR,MageNuggetsClassicStatMonitor.attackpowerValueG,MageNuggetsClassicStatMonitor.attackpowerValueB,1);
    end
    if(MageNuggetsClassicStatMonitor.crit == true) then
        statCount = statCount + 1;
        _G["MageNugSP_FrameText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.critR,MageNuggetsClassicStatMonitor.critG,MageNuggetsClassicStatMonitor.critB,1);
        _G["MageNugSP_FrameValueText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.critValueR,MageNuggetsClassicStatMonitor.critValueG,MageNuggetsClassicStatMonitor.critValueB,1);
    end
    if(MageNuggetsClassicStatMonitor.haste == true) then
        statCount = statCount + 1;
        _G["MageNugSP_FrameText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.hasteR,MageNuggetsClassicStatMonitor.hasteG,MageNuggetsClassicStatMonitor.hasteB,1);
        _G["MageNugSP_FrameValueText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.hasteValueR,MageNuggetsClassicStatMonitor.hasteValueG,MageNuggetsClassicStatMonitor.hasteValueB,1);
    end
    if(MageNuggetsClassicStatMonitor.mastery == true) then
        statCount = statCount + 1;
        _G["MageNugSP_FrameText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.masteryR,MageNuggetsClassicStatMonitor.masteryG,MageNuggetsClassicStatMonitor.masteryB,1);
        _G["MageNugSP_FrameValueText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.masteryValueR,MageNuggetsClassicStatMonitor.masteryValueG,MageNuggetsClassicStatMonitor.masteryValueB,1);
    end
    if(MageNuggetsClassicStatMonitor.hit == true) then
        statCount = statCount + 1;
        _G["MageNugSP_FrameText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.hitR,MageNuggetsClassicStatMonitor.hitG,MageNuggetsClassicStatMonitor.hitB,1);
        _G["MageNugSP_FrameValueText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.hitValueR,MageNuggetsClassicStatMonitor.hitValueG,MageNuggetsClassicStatMonitor.hitValueB,1);
    end
    if(MageNuggetsClassicStatMonitor.versatility == true) then
        statCount = statCount + 1;
        _G["MageNugSP_FrameText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.versatilityR,MageNuggetsClassicStatMonitor.versatilityG,MageNuggetsClassicStatMonitor.versatilityB,1);
        _G["MageNugSP_FrameValueText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.versatilityValueR,MageNuggetsClassicStatMonitor.versatilityValueG,MageNuggetsClassicStatMonitor.versatilityValueB,1);
    end
    if(MageNuggetsClassicStatMonitor.spirit == true) then
        statCount = statCount + 1;
        _G["MageNugSP_FrameText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.spiritR,MageNuggetsClassicStatMonitor.spiritG,MageNuggetsClassicStatMonitor.spiritB,1);
        _G["MageNugSP_FrameValueText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.spiritValueR,MageNuggetsClassicStatMonitor.spiritValueG,MageNuggetsClassicStatMonitor.spiritValueB,1);
    end
    if(MageNuggetsClassicStatMonitor.manaregen == true) then
        statCount = statCount + 1;
        _G["MageNugSP_FrameText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.manaregenR,MageNuggetsClassicStatMonitor.manaregenG,MageNuggetsClassicStatMonitor.manaregenB,1);
        _G["MageNugSP_FrameValueText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.manaregenValueR,MageNuggetsClassicStatMonitor.manaregenValueG,MageNuggetsClassicStatMonitor.manaregenValueB,1);
    end
     if(MageNuggetsClassicStatMonitor.armor == true) then
        statCount = statCount + 1;
        _G["MageNugSP_FrameText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.armorR,MageNuggetsClassicStatMonitor.armorG,MageNuggetsClassicStatMonitor.armorB,1);
        _G["MageNugSP_FrameValueText"..statCount]:SetTextColor(MageNuggetsClassicStatMonitor.armorValueR,MageNuggetsClassicStatMonitor.armorValueG,MageNuggetsClassicStatMonitor.armorValueB,1);
    end
    return statCount;
end
