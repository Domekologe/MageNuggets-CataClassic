MageNuggetsClassicCoolDownMon = {
    toolTips = true;
    clickthru = false;
    cooldownSize = 3;
    removedSpells = {};
}

function MageNuggetCooldownMonitorOptions_Start(self)
    self:RegisterEvent("ADDON_LOADED");
    loadMageNuggetsClassicCdMonOptionsFrames();
    SlashCmdList['MageNuggetsClassicCD_SLASHCMD'] = MageNuggetsClassicCdMon_SlashCommandHandler;
    SLASH_MageNuggetsClassicCD_SLASHCMD1 = "/mncd";
end
--
function MageNuggetsClassicCdMon_SlashCommandHandler(msg)
    if (string.match(msg, "unignore")) then
      local spellName = string.sub(msg, 10, -1);
      removeSpellFromIgnoreList(spellName);
      updateIgnoreListFontString();
    elseif (string.match(msg, "ignore")) then
      local spellName = string.sub(msg, 8, -1);
      addSpellToIgnoreList(spellName);
      updateIgnoreListFontString();
    elseif (string.match(msg, "list")) then
      printIgnoreList();
    else
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff------------|cff00BFFF".."Mage".." |cff00FF00".."Nuggets".."|cffffffff Cooldown Monitor --------------")
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff".."/mncd ignore <spellName>      (add spell to ignore list)")
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff".."/mncd unignore <spellName>   (remove spell from ignore list)")
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff".."/mncd list     (List all ignored spells)")
    end
end
--
function MageNuggetsClassicCooldownMonitorOptions_OnEvent(this, event, ...)
    local argin1, argin2, argin3, argin4, _, argin6 = ...
    if (event == "ADDON_LOADED") then
        if(argin1 == "MageNuggetsClassic_CooldownMonitor") then
           loadMageNuggetCdMonOptionsVariables_OnLoadEvent();
        end
    end
end
--
function loadMageNuggetsClassicCdMonOptionsFrames()
    local MageNugCDOptions = CreateFrame("FRAME", "MageNugCDOptions", InterfaceOptionsFrame)
    MageNugCDOptions.name = "MN Cooldown Monitor"
    InterfaceOptions_AddCategory(MageNugCDOptions)
    MageNugCDOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
end
--
function loadMageNuggetCdMonOptionsVariables_OnLoadEvent()
    if (MageNuggetsClassicCoolDownMon.cooldownSize == nil) then
        MageNugCDOptionsFrame_SizeSlider:SetValue(3);
    else
        MageNugCDOptionsFrame_SizeSlider:SetValue(MageNuggetsClassicCoolDownMon.cooldownSize);
    end

    if (MageNuggetsClassicCoolDownMon.clickthru == nil) then
        MageNugCDOptionsFrame_CheckButtonClickThroughFrame:SetChecked(false);
    else
        MageNugCDOptionsFrame_CheckButtonClickThroughFrame:SetChecked(MageNuggetsClassicCoolDownMon.clickthru);
    end

    if (MageNuggetsClassicCoolDownMon.removedSpells == nil) then
        MageNuggetsClassicCoolDownMon.removedSpells = {};
    end

    MageNugCDOptionsFrame_IgnoreListText:SetWidth(300);
    MageNugCDOptionsFrame_IgnoreListText:SetNonSpaceWrap(true);
    MageNugCDOptionsFrame_IgnoreListText:SetWordWrap(true);
    updateIgnoreListFontString();

    MnCdMonClickThrough()
  --  incombat = 0;
end
--
function MnCdMonClickThrough()
    local clickChecked = MageNugCDOptionsFrame_CheckButtonClickThroughFrame:GetChecked();
    if (clickChecked == true) then
        MageNuggetsClassicCoolDownMon.clickthru = true;
        MageNugCD_Frame:EnableMouse(false)
    else
        MageNuggetsClassicCoolDownMon.clickthru = false;
        MageNugCD_Frame:EnableMouse(true)
    end
end
--
function MNaddSpellToIgnoreListFromEditBox()
  local editBoxText =  MageNugCDOptionsFrame_AddSpellEditBox:GetText();
  addSpellToIgnoreList(editBoxText);
  updateIgnoreListFontString();
end
--
function MNRemoveSpellFromEditBox()
  local editBoxText =  MageNugCDOptionsFrame_AddSpellEditBox:GetText();
  removeSpellFromIgnoreList(editBoxText);
  updateIgnoreListFontString();
end
--
function updateIgnoreListFontString()
  local ignoreList = table.concat(MageNuggetsClassicCoolDownMon.removedSpells, ",  ");
  MageNugCDOptionsFrame_IgnoreListText:SetText(ignoreList);
end
--
function LockFramesToggle()
    local flChecked = MageNugOption2Frame_LockFramesCheckButton:GetChecked();
    if (flChecked == true) then
        MageNuggetsClassicCoolDownMon.lockFrames = true;
    else
        MageNuggetsClassicCoolDownMon.lockFrames = false;
    end
end
--
function LockFramesToggle()
    local flChecked = MageNugOption2Frame_LockFramesCheckButton:GetChecked();
    if (flChecked == true) then
        MageNuggetsClassicCoolDownMon.lockFrames = true;
    else
        MageNuggetsClassicCoolDownMon.lockFrames = false;
    end
end
--
function ConsoleTextToggle()
    local ctChecked = MageNugOption2Frame_ConsoleTextCheckButton:GetChecked();
    if (ctChecked == true) then
        MageNuggetsClassicCoolDownMon.consoleTextEnabled = false;
    else
        MageNuggetsClassicCoolDownMon.consoleTextEnabled = true;
    end
end
--
function MNtoolTipToggle()
    local ttChecked = MageNugOption2Frame_CheckButtonTT:GetChecked();
    if (ttChecked == true) then
        MageNuggetsClassicCoolDownMon.toolTips = true;
    else
        MageNuggetsClassicCoolDownMon.toolTips = false;
    end
end
--
function loadMageNuggetCdMonVariables_OnLoadEvent()
     mnplayerClass, mnenglishClass = UnitClass("player");
    if(mnenglishClass == 'MAGE') then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff Cooldown Monitor loaded! (Use: /mncd)")
    else
      MageNugCD_Frame:Hide();
    end

end

----------------------------------------------------------------------------------------
--                              SAVE FRAMES                                           --
----------------------------------------------------------------------------------------
MageNuggetsClassicCooldownMonitor_Frames = {
    cd_point = "CENTER";
    cd_relativePoint = "CENTER";
    cd_xOfs = 0;
    cd_yOfs = 0;
}

function MageNugz_SaveFrame_Position()
    MageNuggetsClassicCooldownMonitor_Frames.cd_point, _, MageNuggetsClassicCooldownMonitor_Frames.cd_relativePoint, MageNuggetsClassicCooldownMonitor_Frames.cd_xOfs, MageNuggetsClassicCooldownMonitor_Frames.cd_yOfs = MageNugCD_Frame:GetPoint();
end
--
function MageNugzCdMon_SetFrame_Positions()
    MageNugCD_Frame:ClearAllPoints();
    MageNugCD_Frame:SetPoint(MageNuggetsClassicCooldownMonitor_Frames.cd_point, "UIParent", MageNuggetsClassicCooldownMonitor_Frames.cd_relativePoint, MageNuggetsClassicCooldownMonitor_Frames.cd_xOfs, MageNuggetsClassicCooldownMonitor_Frames.cd_yOfs);
end
--
function MNLockFrames(self)
  --  if (MageNuggetsClassicCoolDownMon.lockFrames == false)then
       self:StartMoving(); self.isMoving = true;
  --  end
end
--
function MNcooldownOnEnter()
     if (MageNuggetsClassicCoolDownMon.toolTips == true) then
        GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
        GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."See Mage Nuggets Classic Options -> Cooldowns")
        GameTooltip:Show()
    end
end
