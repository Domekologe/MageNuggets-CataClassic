

 MageNuggetsClassicStatMonitor = {
    spellpower = true;
    attackpower = true;
    crit = true;
    haste = true;
    mastery = true;
    hit = true;
    versatility = true;
    spirit = true;
    manaregen = true;
    armor = true;
    spellpowerR = 1;
    spellpowerG = 1;
    spellpowerB = 1;
    spellpowerValueR = 1;
    spellpowerValueG = 1;
    spellpowerValueB = 1;
    attackpowerR = 1;
    attackpowerG = 1;
    attackpowerB = 1;
    attackpowerValueR = 1;
    attackpowerValueG = 1;
    attackpowerValueB = 1;
    critR = 1;
    critG = 1;
    critB = 1;
    critValueR = 1;
    critValueG = 1;
    critValueB = 1;
    hasteR = 1;
    hasteG = 1;
    hasteB = 1;
    hasteValueR = 1;
    hasteValueG = 1;
    hasteValueB = 1;
    masteryR = 1;
    masteryG = 1;
    masteryB = 1;
    masteryValueR = 1;
    masteryValueG = 1;
    masteryValueB = 1;
    versatilityR = 1;
    versatilityG = 1;
    versatilityB = 1;
    versatilityValueR = 1;
    versatilityValueG = 1;
    versatilityValueB = 1;
    hitR = 1;
    hitG = 1;
    hitB = 1;
    hitValueR = 1;
    hitValueG = 1;
    hitValueB = 1;
    spiritR = 1;
    spiritG = 1;
    spiritB = 1;
    spiritValueR = 1;
    spiritValueG = 1;
    spiritValueB = 1;
    manaregenR = 1;
    manaregenG = 1;
    manaregenB = 1;
    manaregenValueR = 1;
    manaregenValueG = 1;
    manaregenValueB = 1;
    armorR = 1;
    armorG = 1;
    armorB = 1;
    armorValueR = 1;
    armorValueG = 1;
    armorValueB = 1;
    spMonitorToggle = false;
    spCombatToggle = false;
    spMonitorSize = 3;
    lockFrames = false;
    backdropR = 0.0;
    backdropG = 0.0;
    backdropB = 0.0;
    backdropA = 0.0;
    borderStyle = 0;
    transColor = 0;
    statmon_point = "CENTER";
    statmon_relativePoint = "CENTER";
    statmon_xOfs = 0;
    statmon_yOfs = 0;
    clickthru = false;
    limitBreakToggle = false;
    hasteLimit = 0;
    baseSpellPower = 0;
}


function MNStatMonitorOptions_OnLoad(self)
    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")

    local MageNugStatMonitorOptions = CreateFrame("FRAME", "MageNugStatMonitorOptions", InterfaceOptionsFrame)
    MageNugStatMonitorOptions.name = "MN Stat Monitor"
    InterfaceOptions_AddCategory(MageNugStatMonitorOptions)
    MageNugStatMonitorOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
end

function MNStatMonitorOptions_OnEvent(this, event, ...)
    local argin1, argin2, argin3, argin4, _, argin6 = ...
    if (event == "ADDON_LOADED") then
        if(argin1 == "MageNuggetsClassic_StatMonitor") then
            loadMNStatMonitorOptionsFrames();
            loadStatMonitorColors();
            MageNuggetsClassicStatMonitor.baseSpellPower = (GetSpellBonusDamage(3) * 1.20);

            DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFFMage|cff00FF00Nuggets|cffffffff Stat Monitor loaded!")
            MageNugSP_RightClickFrameText:SetText("|cff00BFFFMage |cff00FF00Nuggets|cffffffff Stat Monitor");
            if(MageNuggetsClassicStatMonitor.spCombatToggle == true) then
                MageNugSP_Frame:Hide();
            else
                MageNugSP_Frame:Show();
            end
        end
    elseif (event == "PLAYER_REGEN_ENABLED") then
        if(MageNuggetsClassicStatMonitor.spCombatToggle == true) then
            MageNugSP_Frame:Hide();
        end
    elseif (event == "PLAYER_REGEN_DISABLED") then
        MageNugSP_Frame:Show();
    end
end


function loadMNStatMonitorOptionsFrames()
    if (MageNuggetsClassicStatMonitor.spCombatToggle == nil)then
        MageNuggetsClassicStatMonitor.spCombatToggle = false;
    end
    if (MageNuggetsClassicStatMonitor.spCombatToggle == true) then
        MageNugStatMonOptionMenu_CheckButton0:SetChecked(true);
    else
        MageNugStatMonOptionMenu_CheckButton0:SetChecked(false);
    end
    if (MageNuggetsClassicStatMonitor.limitBreakToggle == nil)then
        MageNuggetsClassicStatMonitor.limitBreakToggle = false;
    end
    if (MageNuggetsClassicStatMonitor.limitBreakToggle == true) then
        MageNugStatMonOptionMenu_CheckButtonLimitBreakFrame:SetChecked(true);
    else
        MageNugStatMonOptionMenu_CheckButtonLimitBreakFrame:SetChecked(false);
    end
    if (MageNuggetsClassicStatMonitor.spMonitorToggle == nil) then
        MageNuggetsClassicStatMonitor.spMonitorToggle = false;
    end
    if (MageNuggetsClassicStatMonitor.spMonitorSize == nil) then
        MageNugStatMonOptionMenu_SPSizeSlider:SetValue(3)
    else
        MageNugStatMonOptionMenu_SPSizeSlider:SetValue(MageNuggetsClassicStatMonitor.spMonitorSize)
    end
    if(MageNuggetsClassicStatMonitor.borderStyle == nil) then
        MageNugStatMonOptionFrame_BorderSlider:SetValue(0);
    else
        MageNugStatMonOptionFrame_BorderSlider:SetValue(MageNuggetsClassicStatMonitor.borderStyle);
    end
    if(MageNuggetsClassicStatMonitor.transColor == nil) then
        MageNugStatMonOptionFrame_TransparencySlider:SetValue(0);
    else
        MageNugStatMonOptionFrame_TransparencySlider:SetValue(MageNuggetsClassicStatMonitor.transColor);
    end
    if (MageNuggetsClassicStatMonitor.lockFrames == nil) then
        MageNuggetsClassicStatMonitor.lockFrames = false;
    end
    if (MageNuggetsClassicStatMonitor.lockFrames == true) then
        MageNugStatMonOptionMenu_CheckButtonLockFrame:SetChecked(true);
    else
        MageNugStatMonOptionMenu_CheckButtonLockFrame:SetChecked(false);
    end

    if (MageNuggetsClassicStatMonitor.clickthru == nil) then
        MageNuggetsClassicStatMonitor.clickthru = false;
    end
    if (MageNuggetsClassicStatMonitor.clickthru == true) then
        MageNugStatMonOptionMenu_CheckButtonClickThroughFrame:SetChecked(true);
        MageNugSP_Frame:EnableMouse(false);
    else
        MageNugStatMonOptionMenu_CheckButtonClickThroughFrame:SetChecked(false);
        MageNugSP_Frame:EnableMouse(true);
    end

end

function MNStatMonitorLockFramesToggle()
    local isChecked = MageNugStatMonOptionMenu_CheckButtonLockFrame:GetChecked();
    if (isChecked == true) then
        MageNuggetsClassicStatMonitor.lockFrames = true;
    else
        MageNuggetsClassicStatMonitor.lockFrames = false;
    end
end

function MNstatMonCombat()
    local statChecked = MageNugStatMonOptionMenu_CheckButton0:GetChecked();
    if (statChecked == true) then
        MageNuggetsClassicStatMonitor.spCombatToggle = true;
        MageNugSP_Frame:Hide();
    else
        MageNuggetsClassicStatMonitor.spCombatToggle = false;
        MageNugSP_Frame:Show();
    end
end

function MNStatMonitorClickThrough()
    local isChecked = MageNugStatMonOptionMenu_CheckButtonClickThroughFrame:GetChecked();
    if (isChecked == true) then
        MageNuggetsClassicStatMonitor.clickthru = true;
        MageNugSP_Frame:EnableMouse(false);
    else
        MageNuggetsClassicStatMonitor.clickthru = false;
        MageNugSP_Frame:EnableMouse(true);
    end
end

function MNStatMonitorLimitBreakToggle()
    local isChecked = MageNugStatMonOptionMenu_CheckButtonLimitBreakFrame:GetChecked();
    if (isChecked == true) then
        MageNuggetsClassicStatMonitor.limitBreakToggle = true;
    else
        MageNuggetsClassicStatMonitor.limitBreakToggle = false;
    end
end

function  MageNugSpMonitorSize()
    local tempInt = MageNugStatMonOptionMenu_SPSizeSlider:GetValue()

    if not MageNugStatMonOptionMenu_SPSizeSlider._onsetting then
        MageNugStatMonOptionMenu_SPSizeSlider._onsetting = true;
        MageNugStatMonOptionMenu_SPSizeSlider:SetValue(MageNugStatMonOptionMenu_SPSizeSlider:GetValue());
        tempInt = MageNugStatMonOptionMenu_SPSizeSlider:GetValue();
        MageNugStatMonOptionMenu_SPSizeSlider._onsetting = false;
    else return end

    if (tempInt == 0) then
        MageNugSP_Frame:SetScale(0.7);
        MageNuggetsClassicStatMonitor.spMonitorSize = 0;
    elseif (tempInt == 1) then
        MageNugSP_Frame:SetScale(0.8);
        MageNuggetsClassicStatMonitor.spMonitorSize = 1;
    elseif (tempInt == 2) then
        MageNugSP_Frame:SetScale(0.9);
        MageNuggetsClassicStatMonitor.spMonitorSize = 2;
    elseif (tempInt == 3) then
        MageNugSP_Frame:SetScale(1.0);
        MageNuggetsClassicStatMonitor.spMonitorSize = 3;
    elseif (tempInt == 4) then
        MageNugSP_Frame:SetScale(1.1);
        MageNuggetsClassicStatMonitor.spMonitorSize = 4;
    elseif (tempInt == 5) then
        MageNugSP_Frame:SetScale(1.2);
        MageNuggetsClassicStatMonitor.spMonitorSize = 5;
    elseif (tempInt == 6) then
        MageNugSP_Frame:SetScale(1.3);
        MageNuggetsClassicStatMonitor.spMonitorSize = 6;
    elseif (tempInt == 7) then
        MageNugSP_Frame:SetScale(1.4);
        MageNuggetsClassicStatMonitor.spMonitorSize = 7;
    elseif (tempInt == 8) then
        MageNugSP_Frame:SetScale(1.5);
        MageNuggetsClassicStatMonitor.spMonitorSize = 8;
    elseif (tempInt == 9) then
        MageNugSP_Frame:SetScale(1.6);
        MageNuggetsClassicStatMonitor.spMonitorSize = 9;
    elseif (tempInt == 10) then
        MageNugSP_Frame:SetScale(1.7);
        MageNuggetsClassicStatMonitor.spMonitorSize = 10;
    elseif (tempInt == 11) then
        MageNugSP_Frame:SetScale(1.8);
        MageNuggetsClassicStatMonitor.spMonitorSize = 11;
    elseif (tempInt == 12) then
        MageNugSP_Frame:SetScale(1.9);
        MageNuggetsClassicStatMonitor.spMonitorSize = 12;
    elseif (tempInt == 13) then
        MageNugSP_Frame:SetScale(2.0);
        MageNuggetsClassicStatMonitor.spMonitorSize = 13;
    elseif (tempInt == 14) then
        MageNugSP_Frame:SetScale(2.1);
        MageNuggetsClassicStatMonitor.spMonitorSize = 14;
    elseif (tempInt == 15) then
        MageNugSP_Frame:SetScale(2.2);
        MageNuggetsClassicStatMonitor.spMonitorSize = 15;
    elseif (tempInt == 16) then
        MageNugSP_Frame:SetScale(2.4);
        MageNuggetsClassicStatMonitor.spMonitorSize = 16;
    elseif (tempInt == 17) then
        MageNugSP_Frame:SetScale(2.6);
        MageNuggetsClassicStatMonitor.spMonitorSize = 17;
    elseif (tempInt == 18) then
        MageNugSP_Frame:SetScale(2.8);
        MageNuggetsClassicStatMonitor.spMonitorSize = 18;
    elseif (tempInt == 19) then
        MageNugSP_Frame:SetScale(3.0);
        MageNuggetsClassicStatMonitor.spMonitorSize = 19;
    end
end


function loadStatMonitorColors()
    if(MageNuggetsClassicStatMonitor.spellpowerR == nil)then
        MageNuggetsClassicStatMonitor.spellpowerR = 1;
    end
    if(MageNuggetsClassicStatMonitor.spellpowerG == nil)then
        MageNuggetsClassicStatMonitor.spellpowerG = 1;
    end
    if(MageNuggetsClassicStatMonitor.spellpowerB == nil)then
        MageNuggetsClassicStatMonitor.spellpowerB = 1;
    end
    if(MageNuggetsClassicStatMonitor.spellpowerValueR == nil)then
        MageNuggetsClassicStatMonitor.spellpowerValueR = 1;
    end
    if(MageNuggetsClassicStatMonitor.spellpowerValueG == nil)then
        MageNuggetsClassicStatMonitor.spellpowerValueG = 1;
    end
    if(MageNuggetsClassicStatMonitor.spellpowerValueB == nil)then
        MageNuggetsClassicStatMonitor.spellpowerValueB = 1;
    end
    if(MageNuggetsClassicStatMonitor.attackpowerR == nil)then
        MageNuggetsClassicStatMonitor.attackpowerR = 1;
    end
    if(MageNuggetsClassicStatMonitor.attackpowerG == nil)then
        MageNuggetsClassicStatMonitor.attackpowerG = 1;
    end
    if(MageNuggetsClassicStatMonitor.attackpowerB == nil)then
        MageNuggetsClassicStatMonitor.attackpowerB = 1;
    end
    if(MageNuggetsClassicStatMonitor.attackpowerValueR == nil)then
        MageNuggetsClassicStatMonitor.attackpowerValueR = 1;
    end
    if(MageNuggetsClassicStatMonitor.attackpowerValueG == nil)then
        MageNuggetsClassicStatMonitor.attackpowerValueG = 1;
    end
    if(MageNuggetsClassicStatMonitor.attackpowerValueB == nil)then
        MageNuggetsClassicStatMonitor.attackpowerValueB = 1;
    end
    if(MageNuggetsClassicStatMonitor.critR == nil)then
        MageNuggetsClassicStatMonitor.critR = 1;
    end
    if(MageNuggetsClassicStatMonitor.critG == nil)then
        MageNuggetsClassicStatMonitor.critG = 1;
    end
    if(MageNuggetsClassicStatMonitor.critB == nil)then
        MageNuggetsClassicStatMonitor.critB = 1;
    end
    if(MageNuggetsClassicStatMonitor.critValueR == nil)then
        MageNuggetsClassicStatMonitor.critValueR = 1;
    end
    if(MageNuggetsClassicStatMonitor.critValueG == nil)then
        MageNuggetsClassicStatMonitor.critValueG = 1;
    end
    if(MageNuggetsClassicStatMonitor.critValueB == nil)then
        MageNuggetsClassicStatMonitor.critValueB = 1;
    end
    if(MageNuggetsClassicStatMonitor.hasteR == nil)then
        MageNuggetsClassicStatMonitor.hasteR = 1;
    end
    if(MageNuggetsClassicStatMonitor.hasteG == nil)then
        MageNuggetsClassicStatMonitor.hasteG = 1;
    end
    if(MageNuggetsClassicStatMonitor.hasteB == nil)then
        MageNuggetsClassicStatMonitor.hasteB = 1;
    end
    if(MageNuggetsClassicStatMonitor.hasteValueR == nil)then
        MageNuggetsClassicStatMonitor.hasteValueR = 1;
    end
    if(MageNuggetsClassicStatMonitor.hasteValueG == nil)then
        MageNuggetsClassicStatMonitor.hasteValueG = 1;
    end
    if(MageNuggetsClassicStatMonitor.hasteValueB == nil)then
        MageNuggetsClassicStatMonitor.hasteValueB = 1;
    end
    if(MageNuggetsClassicStatMonitor.masteryR == nil)then
        MageNuggetsClassicStatMonitor.masteryR = 1;
    end
    if(MageNuggetsClassicStatMonitor.masteryG == nil)then
        MageNuggetsClassicStatMonitor.masteryG = 1;
    end
    if(MageNuggetsClassicStatMonitor.masteryB == nil)then
        MageNuggetsClassicStatMonitor.masteryB = 1;
    end
    if(MageNuggetsClassicStatMonitor.masteryValueR == nil)then
        MageNuggetsClassicStatMonitor.masteryValueR = 1;
    end
    if(MageNuggetsClassicStatMonitor.masteryValueG == nil)then
        MageNuggetsClassicStatMonitor.masteryValueG = 1;
    end
    if(MageNuggetsClassicStatMonitor.masteryValueB == nil)then
        MageNuggetsClassicStatMonitor.masteryValueB = 1;
    end
    if(MageNuggetsClassicStatMonitor.hitR == nil)then
        MageNuggetsClassicStatMonitor.hitR = 1;
    end
    if(MageNuggetsClassicStatMonitor.hitG == nil)then
        MageNuggetsClassicStatMonitor.hitG = 1;
    end
    if(MageNuggetsClassicStatMonitor.hitB == nil)then
        MageNuggetsClassicStatMonitor.hitB = 1;
    end
    if(MageNuggetsClassicStatMonitor.hitValueR == nil)then
        MageNuggetsClassicStatMonitor.hitValueR = 1;
    end
    if(MageNuggetsClassicStatMonitor.hitValueG == nil)then
        MageNuggetsClassicStatMonitor.hitValueG = 1;
    end
    if(MageNuggetsClassicStatMonitor.hitValueB == nil)then
        MageNuggetsClassicStatMonitor.hitValueB = 1;
    end
    if(MageNuggetsClassicStatMonitor.versatilityR == nil)then
        MageNuggetsClassicStatMonitor.versatilityR = 1;
    end
    if(MageNuggetsClassicStatMonitor.versatilityG == nil)then
        MageNuggetsClassicStatMonitor.versatilityG = 1;
    end
    if(MageNuggetsClassicStatMonitor.versatilityB == nil)then
        MageNuggetsClassicStatMonitor.versatilityB = 1;
    end
    if(MageNuggetsClassicStatMonitor.versatilityValueR == nil)then
        MageNuggetsClassicStatMonitor.versatilityValueR = 1;
    end
    if(MageNuggetsClassicStatMonitor.versatilityValueG == nil)then
        MageNuggetsClassicStatMonitor.versatilityValueG = 1;
    end
    if(MageNuggetsClassicStatMonitor.versatilityValueB == nil)then
        MageNuggetsClassicStatMonitor.versatilityValueB = 1;
    end
    if(MageNuggetsClassicStatMonitor.spiritR == nil)then
        MageNuggetsClassicStatMonitor.spiritR = 1;
    end
    if(MageNuggetsClassicStatMonitor.spiritG == nil)then
        MageNuggetsClassicStatMonitor.spiritG = 1;
    end
    if(MageNuggetsClassicStatMonitor.spiritB == nil)then
        MageNuggetsClassicStatMonitor.spiritB = 1;
    end
    if(MageNuggetsClassicStatMonitor.spiritValueR == nil)then
        MageNuggetsClassicStatMonitor.spiritValueR = 1;
    end
    if(MageNuggetsClassicStatMonitor.spiritValueG == nil)then
        MageNuggetsClassicStatMonitor.spiritValueG = 1;
    end
    if(MageNuggetsClassicStatMonitor.spiritValueB == nil)then
        MageNuggetsClassicStatMonitor.spiritValueB = 1;
    end
    if(MageNuggetsClassicStatMonitor.manaregenR == nil)then
        MageNuggetsClassicStatMonitor.manaregenR = 1;
    end
    if(MageNuggetsClassicStatMonitor.manaregenG == nil)then
        MageNuggetsClassicStatMonitor.manaregenG = 1;
    end
    if(MageNuggetsClassicStatMonitor.manaregenB == nil)then
        MageNuggetsClassicStatMonitor.manaregenB = 1;
    end
    if(MageNuggetsClassicStatMonitor.manaregenValueR == nil)then
        MageNuggetsClassicStatMonitor.manaregenValueR = 1;
    end
    if(MageNuggetsClassicStatMonitor.manaregenValueG == nil)then
        MageNuggetsClassicStatMonitor.manaregenValueG = 1;
    end
    if(MageNuggetsClassicStatMonitor.manaregenValueB == nil)then
        MageNuggetsClassicStatMonitor.manaregenValueB = 1;
    end
    if(MageNuggetsClassicStatMonitor.armorR == nil)then
        MageNuggetsClassicStatMonitor.armorR = 1;
    end
    if(MageNuggetsClassicStatMonitor.armorG == nil)then
        MageNuggetsClassicStatMonitor.armorG = 1;
    end
    if(MageNuggetsClassicStatMonitor.armorB == nil)then
        MageNuggetsClassicStatMonitor.armorB = 1;
    end
    if(MageNuggetsClassicStatMonitor.armorValueR == nil)then
        MageNuggetsClassicStatMonitor.armorValueR = 1;
    end
    if(MageNuggetsClassicStatMonitor.armorValueG == nil)then
        MageNuggetsClassicStatMonitor.armorValueG = 1;
    end
    if(MageNuggetsClassicStatMonitor.armorValueB == nil)then
        MageNuggetsClassicStatMonitor.armorValueB = 1;
    end
end

local currentStatColor;
function setCurrentStatColor(index)
    currentStatColor = index;
end

function statMonitorColorSelect()
    if(currentStatColor == 1) then
        MageNuggetsClassicStatMonitor.spellpowerR, MageNuggetsClassicStatMonitor.spellpowerG, MageNuggetsClassicStatMonitor.spellpowerB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 2) then
        MageNuggetsClassicStatMonitor.spellpowerValueR, MageNuggetsClassicStatMonitor.spellpowerValueG, MageNuggetsClassicStatMonitor.spellpowerValueB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 3) then
        MageNuggetsClassicStatMonitor.attackpowerR, MageNuggetsClassicStatMonitor.attackpowerG, MageNuggetsClassicStatMonitor.attackpowerB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 4) then
        MageNuggetsClassicStatMonitor.attackpowerValueR, MageNuggetsClassicStatMonitor.attackpowerValueG, MageNuggetsClassicStatMonitor.attackpowerValueB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 5) then
        MageNuggetsClassicStatMonitor.critR, MageNuggetsClassicStatMonitor.critG, MageNuggetsClassicStatMonitor.critB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 6) then
        MageNuggetsClassicStatMonitor.critValueR, MageNuggetsClassicStatMonitor.critValueG, MageNuggetsClassicStatMonitor.critValueB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 7) then
        MageNuggetsClassicStatMonitor.hasteR, MageNuggetsClassicStatMonitor.hasteG, MageNuggetsClassicStatMonitor.hasteB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 8) then
        MageNuggetsClassicStatMonitor.hasteValueR, MageNuggetsClassicStatMonitor.hasteValueG, MageNuggetsClassicStatMonitor.hasteValueB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 9) then
        MageNuggetsClassicStatMonitor.masteryR, MageNuggetsClassicStatMonitor.masteryG, MageNuggetsClassicStatMonitor.masteryB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 10) then
       MageNuggetsClassicStatMonitor.masteryValueR, MageNuggetsClassicStatMonitor.masteryValueG, MageNuggetsClassicStatMonitor.masteryValueB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 13) then
        MageNuggetsClassicStatMonitor.hitR, MageNuggetsClassicStatMonitor.hitG, MageNuggetsClassicStatMonitor.hitB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 14) then
        MageNuggetsClassicStatMonitor.hitValueR, MageNuggetsClassicStatMonitor.hitValueG, MageNuggetsClassicStatMonitor.hitValueB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 15) then
        MageNuggetsClassicStatMonitor.versatilityR, MageNuggetsClassicStatMonitor.versatilityG, MageNuggetsClassicStatMonitor.versatilityB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 16) then
        MageNuggetsClassicStatMonitor.versatilityValueR, MageNuggetsClassicStatMonitor.versatilityValueG, MageNuggetsClassicStatMonitor.versatilityValueB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 17) then
        MageNuggetsClassicStatMonitor.spiritR, MageNuggetsClassicStatMonitor.spiritG, MageNuggetsClassicStatMonitor.spiritB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 18) then
        MageNuggetsClassicStatMonitor.spiritValueR, MageNuggetsClassicStatMonitor.spiritValueG, MageNuggetsClassicStatMonitor.spiritValueB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 19) then
        MageNuggetsClassicStatMonitor.manaregenR, MageNuggetsClassicStatMonitor.manaregenG, MageNuggetsClassicStatMonitor.manaregenB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 20) then
        MageNuggetsClassicStatMonitor.manaregenValueR, MageNuggetsClassicStatMonitor.manaregenValueG, MageNuggetsClassicStatMonitor.manaregenValueB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 21) then
        MageNuggetsClassicStatMonitor.armorR, MageNuggetsClassicStatMonitor.armorG, MageNuggetsClassicStatMonitor.armorB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    elseif(currentStatColor == 22) then
        MageNuggetsClassicStatMonitor.armorValueR, MageNuggetsClassicStatMonitor.armorValueG, MageNuggetsClassicStatMonitor.armorValueB = MageNugSP_ColorPickerFrameColorSelect:GetColorRGB();
    end
    dressStatMonitorText();
end

function MageNugz_SaveFrame_Position()
    MageNuggetsClassicStatMonitor.statmon_point, _, MageNuggetsClassicStatMonitor.statmon_relativePoint, MageNuggetsClassicStatMonitor.statmon_xOfs, MageNuggetsClassicStatMonitor.statmon_yOfs = MageNugSP_Frame:GetPoint();
end


function MageNugz_SetFrame_Positions()
    MageNugSP_Frame:ClearAllPoints();
    MageNugSP_Frame:SetPoint(MageNuggetsClassicStatMonitor.statmon_point, "UIParent", MageNuggetsClassicStatMonitor.statmon_relativePoint, MageNuggetsClassicStatMonitor.statmon_xOfs, MageNuggetsClassicStatMonitor.statmon_yOfs);
end


function MNStatMonitorLockFrames(self)
    if (MageNuggetsClassicStatMonitor.lockFrames == false)then
       self:StartMoving(); self.isMoving = true;
    end
end

function BorderTypeSlider()
    local tempInt = MageNugStatMonOptionFrame_BorderSlider:GetValue()
    tempInt = roundZero(tempInt);
    if (tempInt == 0) then
         MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                                    tile = true, tileSize = 16, edgeSize = 16,
                                    insets = { left = 4, right = 4, top = 4, bottom = 4 }});
        MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
        MageNuggetsClassicStatMonitor.borderStyle = 0;
    elseif (tempInt == 1) then
         MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                                    tile = true, tileSize = 16, edgeSize = 8,
                                    insets = { left = 1, right = 1, top = 1, bottom = 1 }});
        MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
        MageNuggetsClassicStatMonitor.borderStyle = 1;
    elseif (tempInt == 2) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
                                    tile = true, tileSize = 16, edgeSize = 16,
                                    insets = { left = 4, right = 4, top = 4, bottom = 4 }});
        MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
        MageNuggetsClassicStatMonitor.borderStyle = 2;
    elseif (tempInt == 3) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
                                    tile = true, tileSize = 16, edgeSize = 8,
                                    insets = { left = 1, right = 1, top = 1, bottom = 1 }});
        MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
        MageNuggetsClassicStatMonitor.borderStyle = 3;
    elseif (tempInt == 4) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    edgeFile = "Interface/DialogFrame/UI-DialogBox-Gold-Border",
                                    tile = true, tileSize = 16, edgeSize = 16,
                                    insets = { left = 4, right = 4, top = 4, bottom = 4 }});
        MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
        MageNuggetsClassicStatMonitor.borderStyle = 4;
    elseif (tempInt == 5) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    edgeFile = "Interface/DialogFrame/UI-DialogBox-Gold-Border",
                                    tile = true, tileSize = 16, edgeSize = 8,
                                    insets = { left = 1, right = 1, top = 1, bottom = 1 }});
        MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
        MageNuggetsClassicStatMonitor.borderStyle = 5;
    elseif (tempInt == 6) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    tile = true, tileSize = 16, edgeSize = 16,
                                    insets = { left = 4, right = 4, top = 4, bottom = 4 }});
        MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
        MageNuggetsClassicStatMonitor.borderStyle = 6;
    end
end


function BackdropTransparencySlider()
    local tempInt = MageNugStatMonOptionFrame_TransparencySlider:GetValue()
    tempInt = roundZero(tempInt);
    if (tempInt == 0) then
        MageNuggetsClassicStatMonitor.backdropA = 1.0;
        MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
        MageNuggetsClassicStatMonitor.transColor = 0;
    elseif (tempInt == 1) then
        MageNuggetsClassicStatMonitor.backdropA = 0.85;
        MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
        MageNuggetsClassicStatMonitor.transColor = 1;
    elseif (tempInt == 2) then
        MageNuggetsClassicStatMonitor.backdropA = 0.7;
        MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
        MageNuggetsClassicStatMonitor.transColor = 2;
    elseif (tempInt == 3) then
        MageNuggetsClassicStatMonitor.backdropA = 0.55;
        MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
        MageNuggetsClassicStatMonitor.transColor = 3;
    elseif (tempInt == 4) then
        MageNuggetsClassicStatMonitor.backdropA = 0.4;
        MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
        MageNuggetsClassicStatMonitor.transColor = 4;
    elseif (tempInt == 5) then
        MageNuggetsClassicStatMonitor.backdropA = 0.25;
        MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
        MageNuggetsClassicStatMonitor.transColor = 5;
    elseif (tempInt == 6) then
        MageNuggetsClassicStatMonitor.backdropA = 0.0;
        MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
        MageNuggetsClassicStatMonitor.transColor = 6;
    end
end

function MNSetBackdropBlack()
    MageNuggetsClassicStatMonitor.backdropR = 0.0;
    MageNuggetsClassicStatMonitor.backdropG = 0.0;
    MageNuggetsClassicStatMonitor.backdropB = 0.0;
    MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA)
end

function MNColorSelector()
    MageNuggetsClassicStatMonitor.backdropR, MageNuggetsClassicStatMonitor.backdropG, MageNuggetsClassicStatMonitor.backdropB = MageNugStatMonOptionFrameColorSelect:GetColorRGB();
    MageNugSP_Frame:SetBackdropColor(MageNuggetsClassicStatMonitor.backdropR,MageNuggetsClassicStatMonitor.backdropG,MageNuggetsClassicStatMonitor.backdropB,MageNuggetsClassicStatMonitor.backdropA);
end


function MNRecallFrames()
    MageNugSP_Frame:SetClampedToScreen(true);
end
