local magenugVer = "8.3.5"

MageNuggetsClassic = {
    ssMonitorToggle = true;
    mageProcToggle = true;
    camZoomTogg = true;
    mirrorImageToggle = true;
    procMonitorToggle = true;
    arcaneBlastToggle = true;
    abCastTimeToggle = true;
    minimapToggle = true;
    polyToggle = true;
    ssMonitorSize = 3;
    mgCombatTog = false;
    procMonitorSize = 3;
    arcaneBlastSize=3;
    lockFrames = false;
    consoleTextEnabled = true;
    slowfallMsg = "Slowfall Cast On You";
    slowfallMsg2 = "Slowfall Cast On You";
    slowfallMsg3 = "Slowfall Cast On You";
    innervatThanks = "Thanks For The Innervate";
    innervatThanks2 = "Thanks For The Innervate";
    powerinfThanks = "Thanks For Power Infusion";
    painSupNotify = "Pain Suppression Cast On You";
    gspiritNotify = "Guardian Spirit Cast On You";
    MinimapPos = 45;
    miSound2 = "mirror.mp3";
    miSoundToggle = true;
    procSound2 = "proc.mp3";
    polySound2 = "sheep.mp3";
    ABSound2 = "impact.mp3";
    hsSound2 = "hotstreak.mp3";
    impactSound2 = "impact.mp3";
    fofSound2 = "fof.mp3";
    brainfreezeSound2 = "brainfreeze.mp3";
    cauterizeSound2 = "toasty.mp3";
    timewarpSound2 = "timewarp.mp3";
    cauterizeSoundToggle = true;
    timewarpSoundToggle = true;
    procSoundToggle = true;
    polySoundToggle = true;
    ABSoundToggle = true;
    hsSoundToggle = true;
    impactSoundToggle = true;
    fofSoundToggle = true;
    brainfreezeSoundToggle = true;
    toolTips = true;
    clickthru = false;
    polyFrameSize = 3;
    msgToggle = true;
    moonkinTog = false;
    moonkinSize = 3;
    moonkinCombat = false;
    treantSoundTog = true;
    treantSound2 = "mirror.mp3";
    moonkinProcTog = true;
    innervatNotify = "Innervate Cast On You!";
    igniteTog = true;
    moonkinProcSize = 3;
    starfallCooldown = true;
    blinkCooldown = true;
    treantCooldown = true;
    moonkinMin = false;
    moonkinAnchorTog = true;
    cauterizeToggle = true;
    moonkinBoxTog = true;
    symbiosisnToggle = true;
    symbiosistyToggle = true;
    innertyToggle = true;
    painSupToggle = true;
    gspiritToggle = true;
    cautSize = 3;
    simpleUiToggle = false;
    bombMouseOverMacro = false;
    novaMonitorToggle = true;
    fireNuggetSize = 3;
    fireNuggetBorder = 1;
    fireNugSimpleUiToggle = false;
    FireNuggetNotifyBorderToggle = true;
}

function MageNuggetOptions_Start(self)
    self:RegisterEvent("ADDON_LOADED")
    loadMageNuggetsClassicOptionsFrames();
    SlashCmdList['MageNuggetsClassic_SLASHCMD'] = MageNuggetsClassic_SlashCommandHandler
    SLASH_MageNuggetsClassic_SLASHCMD1 = "/MageNuggetsClassic"
end

function MageNuggetsClassicOptions_OnEvent(this, event, ...)
    local argin1, argin2, argin3, argin4, _, argin6 = ...
    if (event == "ADDON_LOADED") then
        if(argin1 == "MageNuggetsClassic") then
           loadMageNuggetOptionsVariables_OnLoadEvent();
           MageNuggetsClassicSoundOptionsOnLoad();
        end

        -- If running sexy maps use the correct mini map position
        if(argin1 == "SexyMap") then
          DEFAULT_CHAT_FRAME:AddMessage("SEXY MAP!!");
          MageNugz_MinimapButton_Move_SexyMaps()
        end
    end
end

function MageNuggetsClassic_SlashCommandHandler(msg)
    if (msg == "options") then
		local panel = CreateFrame("Frame")
		panel.name = "Mage Nuggets Classic"               -- see panel fields
	    InterfaceOptionsFrame_OpenToCategory(panel);
    elseif (msg == "ports") then
        MageNugz_Minimap_OnClick();
    else
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff------------|cff00BFFF".."Mage".." |cff00FF00".."Nuggets".."|cffffffff "..magenugVer.."--------------")
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff".."/MageNuggetsClassic".." ".."options (Shows Option Menu)")
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff".."/MageNuggetsClassic".." ".."ports (Shows Portal Menu)")
    end
end


function loadMageNuggetsClassicOptionsFrames()
    local MageNugOptions = CreateFrame("FRAME", "MageNugOptions", InterfaceOptionsFrame)
    MageNugOptions.name = "Mage Nuggets"
    local mainCategory, mainLayout = Settings.RegisterCanvasLayoutCategory(MageNugOptions, MageNugOptions.name);
    mainCategory.ID = MageNugOptions.name
    Settings.RegisterAddOnCategory(mainCategory);
    MageNugOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

    local fireNuggetOptions = CreateFrame("FRAME", "fireNuggetOptions");
    fireNuggetOptions.name = "Fire Nugget";
    fireNuggetOptions.parent = mainCategory;
    local fireNuggetCategory, fireMuggetLayout = Settings.RegisterCanvasLayoutSubcategory(mainCategory, fireNuggetOptions, fireNuggetOptions.name);
    fireNuggetCategory.ID = fireNuggetOptions.name
    Settings.RegisterAddOnCategory(fireNuggetCategory);
    fireNuggetOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

    local msgOptions = CreateFrame("FRAME", "msgOptions");
    msgOptions.name = "Messages";
    msgOptions.parent = "Mage Nuggets";
    local msgCategory, msgLayout = Settings.RegisterCanvasLayoutSubcategory(mainCategory, msgOptions, msgOptions.name);
    msgCategory.ID = msgOptions.name
    Settings.RegisterAddOnCategory(msgCategory);
    msgOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

    local soundOptions = CreateFrame("FRAME", "soundOptions");
    soundOptions.name = "Sounds";
    soundOptions.parent = "Mage Nuggets";
    local soundCategory, soundLayout = Settings.RegisterCanvasLayoutSubcategory(mainCategory, soundOptions, soundOptions.name);
    soundCategory.ID = soundOptions.name
    Settings.RegisterAddOnCategory(soundCategory);
    soundOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

    local priestOptions = CreateFrame("FRAME", "priestOptions");
    priestOptions.name = "Priest";
    priestOptions.parent = "Mage Nuggets";
    local priestCategory, priestLayout = Settings.RegisterCanvasLayoutSubcategory(mainCategory, priestOptions, priestOptions.name);
    priestCategory.ID = priestOptions.name
    Settings.RegisterAddOnCategory(priestCategory);
    priestOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

    local moonkinOptions = CreateFrame("FRAME", "moonkinOptions");
    moonkinOptions.name = "Moonkin";
    moonkinOptions.parent = "Mage Nuggets";
    local moonkinCategory, moonkinLayout = Settings.RegisterCanvasLayoutSubcategory(mainCategory, moonkinOptions, moonkinOptions.name);
    moonkinCategory.ID = moonkinOptions.name
    Settings.RegisterAddOnCategory(moonkinCategory);
    moonkinOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

    local mnOptions = CreateFrame("FRAME", "mnOptions");
    mnOptions.name = "Options";
    mnOptions.parent = "Mage Nuggets";
    local mnCategory, mnLayout = Settings.RegisterCanvasLayoutSubcategory(mainCategory, mnOptions, mnOptions.name);
    mnCategory.ID = mnOptions.name
    Settings.RegisterAddOnCategory(mnCategory);
    mnOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
end



function loadMageNuggetOptionsVariables_OnLoadEvent()
    if(MageNuggetsClassic.bombMouseOverMacro == nil) then
        MageNuggetsClassic.bombMouseOverMacro = false;
    end
    if(MageNuggetsClassic.bombMouseOverMacro == true) then
    --    MageNugOption2Frame_MinimapCheckButton:SetChecked(true);
    else
      --  MageNugOption2Frame_MinimapCheckButton:SetChecked(false);
    end
    if (MageNuggetsClassic.minimapToggle == nil) then
        MageNuggetsClassic.minimapToggle = true;
    end
    if (MageNuggetsClassic.minimapToggle == true) then
        MageNug_MinimapFrame:Show();
        MageNugOption2Frame_MinimapCheckButton:SetChecked(false);
    else
        MageNug_MinimapFrame:Hide();
        MageNugOption2Frame_MinimapCheckButton:SetChecked(true);
    end
    if (MageNuggetsClassic.ssMonitorToggle == true) then
        MageNugOptionsFrame_CheckButton2:SetChecked(false);
    else
        MageNugOptionsFrame_CheckButton2:SetChecked(true);
    end
    if(MageNuggetsClassic.abCastTimeToggle == true) then
        MageNugOptionsFrame_ABcastCheckButton:SetChecked(true);
    else
        MageNugOptionsFrame_ABcastCheckButton:SetChecked(false);
    end
    if (MageNuggetsClassic.mageProcToggle == true) or (MageNuggetsClassic.mageProcToggle == nil) then
        MageNugOptionsFrame_CheckButton3:SetChecked(false);
        MageNuggetsClassic.mageProcToggle = true;
    else
        MageNugOptionsFrame_CheckButton3:SetChecked(true);
    end
    if(MageNuggetsClassic.igniteTog == true) or (MageNuggetsClassic.igniteTog == nil) then
        MageNugFireNugOptionFrame_IgniteCheckButton:SetChecked(true);
        MageNuggetsClassic.igniteTog = true;
    else
        MageNugFireNugOptionFrame_IgniteCheckButton:GetChecked(false);
    end
    if (MageNuggetsClassic.mirrorImageToggle == true) then
        MageNugOptionsFrame_CheckButton6:SetChecked(false);
    else
        MageNugOptionsFrame_CheckButton6:SetChecked(true);
    end
    if(MageNuggetsClassic.abCastTimeToggle == nil) then
        MageNuggetsClassic.abCastTimeToggle = true;
    end
    if (MageNuggetsClassic.arcaneBlastToggle == true) then
        MageNugOptionsFrame_CheckButton13:SetChecked(false);
    else
        MageNugOptionsFrame_CheckButton13:SetChecked(true);
    end
    if (MageNuggetsClassic.polyToggle == true) then
        MageNugOptionsFrame_CheckButton14:SetChecked(false);
    else
        MageNugOptionsFrame_CheckButton14:SetChecked(true);
    end

    if (MageNuggetsClassic.novaMonitorToggle == nil) then
        MageNuggetsClassic.novaMonitorToggle = true;
    end
    if (MageNuggetsClassic.novaMonitorToggle == true) then
        MageNugOptionsFrame_CheckButtonNova:SetChecked(false);
    else
        MageNugOptionsFrame_CheckButtonNova:SetChecked(true);
    end

    if(MageNuggetsClassic.mgCombatTog == nil) then
        MageNuggetsClassic.mgCombatTog = false;
    end
    if (MageNuggetsClassic.procMonitorToggle == nil) then
        MageNuggetsClassic.procMonitorToggle = true;
    end
    if (MageNuggetsClassic.procMonitorToggle == true) then
        MageNugOptionsFrame_CheckButton11:SetChecked(false);
    else
        MageNugOptionsFrame_CheckButton11:SetChecked(true);
    end
    if (MageNuggetsClassic.ssMonitorSize == nil) then
        MageNugOptionsFrame_Slider2:SetValue(3)
    else
        MageNugOptionsFrame_Slider2:SetValue(MageNuggetsClassic.ssMonitorSize)
    end

    if (MageNuggetsClassic.polyFrameSize == nil) then
        MageNugOptionsFrame_Slider1:SetValue(3)
    else
        MageNugOptionsFrame_Slider1:SetValue(MageNuggetsClassic.polyFrameSize)
    end

    if (MageNuggetsClassic.cautSize == nil) then
        MageNugOptionsFrame_Slider5:SetValue(3)
    else
        MageNugOptionsFrame_Slider5:SetValue(MageNuggetsClassic.cautSize)
    end
    if (MageNuggetsClassic.arcaneBlastSize == nil) then
        MageNugOptionsFrame_Slider3:SetValue(3)
    else
        MageNugOptionsFrame_Slider3:SetValue(MageNuggetsClassic.arcaneBlastSize)
    end
    if (MageNuggetsClassic.procMonitorSize == nil) then
        MageNugOptionsFrame_Slider4:SetValue(3)
    else
        MageNugOptionsFrame_Slider4:SetValue(MageNuggetsClassic.procMonitorSize)
    end
    -----Messages Options----
    if (MageNuggetsClassic.msgToggle == nil) then
        MageNuggetsClassic.msgToggle = true;
    end
    if (MageNuggetsClassic.msgToggle == true) then
        MageNugMsgOptionFrame_CheckButton:SetChecked(true);
    else
        MageNugMsgOptionFrame_CheckButton:SetChecked(false);
    end
    if (MageNuggetsClassic.innertyToggle == nil) then
        MageNuggetsClassic.innertyToggle = true;
    end
    if (MageNuggetsClassic.innertyToggle == true) then
        MageNugMsgOptionFrame_CheckButton4:SetChecked(true);
    else
        MageNugMsgOptionFrame_CheckButton4:SetChecked(false);
    end
    if (MageNuggetsClassic.slowfallMsg == nil) or (MageNuggetsClassic.slowfallMsg == "") then
        SlowFallMsgEditBox:SetText("Slowfall Cast On You")
    else
        SlowFallMsgEditBox:SetText(MageNuggetsClassic.slowfallMsg)
    end
    if (MageNuggetsClassic.slowfallMsg2 == nil) or (MageNuggetsClassic.slowfallMsg2 == "") then
        SlowFallMsgEditBox2:SetText("Slowfall Cast On You")
    else
        SlowFallMsgEditBox2:SetText(MageNuggetsClassic.slowfallMsg2)
    end
    if (MageNuggetsClassic.slowfallMsg3 == nil) or (MageNuggetsClassic.slowfallMsg3 == "")then
        SlowFallMsgEditBox3:SetText("Slowfall Cast On You")
    else
        SlowFallMsgEditBox3:SetText(MageNuggetsClassic.slowfallMsg3)
    end
    if (MageNuggetsClassic.innervatThanks == nil) or (MageNuggetsClassic.innervatThanks == "") then
        InnervThankEditBox:SetText("Thanks For The Innervate")
    else
        InnervThankEditBox:SetText(MageNuggetsClassic.innervatThanks)
    end
    if (MageNuggetsClassic.innervatThanks2 == nil) or (MageNuggetsClassic.innervatThanks2 == "") then
        InnervThankEditBox2:SetText("Thanks For The Innervate")
    else
        InnervThankEditBox2:SetText(MageNuggetsClassic.innervatThanks2)
    end

    ----fire nugget options----
    if(MageNuggetsClassic.fireNuggetSize == nil)then
      MageNugFireNugOptionFrame_SizeSlider:SetValue(3);
    else
      MageNugFireNugOptionFrame_SizeSlider:SetValue(MageNuggetsClassic.fireNuggetSize);
    end
    if(MageNuggetsClassic.fireNuggetBorder == nil)then
      MageNugFireNugOptionFrame_BorderSlider:SetValue(1);
    else
      MageNugFireNugOptionFrame_BorderSlider:SetValue(MageNuggetsClassic.fireNuggetBorder);
    end
    if(MageNuggetsClassic.FireNuggetNotifyBorderToggle == nil)then
      MageNugFireNugOptionFrame_NotifyCheckButton:SetChecked(true);
    else
      MageNugFireNugOptionFrame_NotifyCheckButton:SetChecked(MageNuggetsClassic.FireNuggetNotifyBorderToggle);
    end
    if(MageNuggetsClassic.fireNugSimpleUiToggle == nil)then
      MageNugFireNugOptionFrame_SimpleUiCheckButton:SetChecked(false);
    else
      MageNugFireNugOptionFrame_SimpleUiCheckButton:SetChecked(MageNuggetsClassic.fireNugSimpleUiToggle);
    end
    MNFireNuggetSimpleUiToggle();
    --------Options 2--------
    MNcheckboxMiniMapFontString:SetText("Disable Minimap Button")
    MNcheckboxCameraFontString:SetText("Disable Maximum Camera Zoom Out")
    MNcheckboxConsoleTextFontString:SetText("Disable Console Text")
    MNcheckboxLockFramesFontString:SetText("Lock Frames")
    MNcheckboxTTFontString:SetText("Tool Tips")
    MNcheckboxClickThruFontString:SetText("Enable Frame Click Through")
    if (MageNuggetsClassic.MinimapPos == nil) then
        MageNuggetsClassic.MinimapPos = 45;
    end
    if (MageNuggetsClassic.camZoomTogg == true) then
        ConsoleExec("cameraDistanceMaxFactor 2.6");
        MageNugOption2Frame_CameraCheckButton:SetChecked(false);
    else
        MageNugOption2Frame_CameraCheckButton:SetChecked(true);
    end
    if (MageNuggetsClassic.lockFrames == nil) then
        MageNuggetsClassic.lockFrames = false;
    end
    if (MageNuggetsClassic.lockFrames == true) then
        MageNugOption2Frame_LockFramesCheckButton:SetChecked(true);
    else
        MageNugOption2Frame_LockFramesCheckButton:SetChecked(false);
    end
    if (MageNuggetsClassic.consoleTextEnabled == nil) then
        MageNuggetsClassic.consoleTextEnabled = true;
    end
    if (MageNuggetsClassic.consoleTextEnabled == true) then
        MageNugOption2Frame_ConsoleTextCheckButton:SetChecked(false);
    else
        MageNugOption2Frame_ConsoleTextCheckButton:SetChecked(true);
    end
    if (MageNuggetsClassic.toolTips == nil) then
        MageNuggetsClassic.toolTips = true;
    end
    if (MageNuggetsClassic.toolTips == true) then
        MageNugOption2Frame_CheckButtonTT:SetChecked(true);
    else
        MageNugOption2Frame_CheckButtonTT:SetChecked(false);
    end
    if (MageNuggetsClassic.clickthru == nil) then
        MageNuggetsClassic.clickthru = false;
    end
    if (MageNuggetsClassic.clickthru == true) then
        MageNugOption2Frame_ClickThruCheckButton:SetChecked(true);
    else
        MageNugOption2Frame_ClickThruCheckButton:SetChecked(false);
    end
    if (MageNuggetsClassic.simpleUiToggle == nil) then
        MageNuggetsClassic.simpleUiToggle = false;
    end
    if (MageNuggetsClassic.simpleUiToggle == true) then
        MageNugOption2Frame_SimpleUICheckButton:SetChecked(true);
    else
        MageNugOption2Frame_SimpleUICheckButton:SetChecked(false);
    end
    MNsimpleUItoggle();

    if (MageNuggetsClassic.cauterizeToggle == true) or (MageNuggetsClassic.cauterizeToggle == nil) then
        CauterizeCheckButton:SetChecked(true);
        MageNuggetsClassic.cauterizeToggle = true;
    else
        CauterizeCheckButton:SetChecked(false);
    end

    --------Priest---------------

    if(MageNuggetsClassic.powerInfToggle == true) or (MageNuggetsClassic.powerInfToggle == nil)then
        MageNugPriestOptionFrame_CheckButton0:SetChecked(true);
        MageNuggetsClassic.powerInfToggle = true;
    else
        MageNugPriestOptionFrame_CheckButton0:SetChecked(false);
        MageNuggetsClassic.powerInfToggle = false;
    end
    if (MageNuggetsClassic.powerinfNotify == nil) or (MageNuggetsClassic.powerinfNotify == "") then
        MageNugPriestOptionFrame_EditBox1:SetText("Power Infusion Cast On You")
    else
        MageNugPriestOptionFrame_EditBox1:SetText(MageNuggetsClassic.powerinfNotify)
    end
    if(MageNuggetsClassic.painSupToggle == true) or (MageNuggetsClassic.painSupToggle == nil)then
        MageNugPriestOptionFrame_CheckButton2:SetChecked(true);
        MageNuggetsClassic.painSupToggle = true;
    else
        MageNugPriestOptionFrame_CheckButton2:SetChecked(false);
        MageNuggetsClassic.painSupToggle = false;
    end
    if (MageNuggetsClassic.painSupNotify == nil) or (MageNuggetsClassic.painSupNotify == "") then
        MageNugPriestOptionFrame_EditBox2:SetText("Pain Suppression Cast On You")
    else
        MageNugPriestOptionFrame_EditBox2:SetText(MageNuggetsClassic.painSupNotify)
    end
    if(MageNuggetsClassic.gspiritToggle == true) or (MageNuggetsClassic.gspiritToggle == nil)then
        MageNugPriestOptionFrame_CheckButton3:SetChecked(true);
        MageNuggetsClassic.gspiritToggle = true;
    else
        MageNugPriestOptionFrame_CheckButton3:SetChecked(false);
        MageNuggetsClassic.gspiritToggle = false;
    end
    if (MageNuggetsClassic.gspiritNotify == nil) or (MageNuggetsClassic.gspiritNotify == "") then
        MageNugPriestOptionFrame_EditBox3:SetText("Guardian Spirit Cast On You")
    else
        MageNugPriestOptionFrame_EditBox3:SetText(MageNuggetsClassic.gspiritNotify)
    end
    -----moonkin options--------
    if(MageNuggetsClassic.moonkinBoxTog == true) or (MageNuggetsClassic.moonkinBoxTog == nil)then
        MageNugMoonkinOptionFrame_CheckButton0:SetChecked(true);
        MageNuggetsClassic.moonkinBoxTog = true;
    else
        MageNugMoonkinOptionFrame_CheckButton0:SetChecked(false);
        MageNuggetsClassic.moonkinBoxTog = false;
    end
    if(MageNuggetsClassic.moonkinTog == nil) then
        MageNuggetsClassic.moonkinTog = false;
    end
    if (MageNuggetsClassic.moonkinTog == true) then
        MageNugMoonkinOptionFrame_CheckButton:SetChecked(true);
        MageNugMoonkin_Frame:Hide();
        MNmoonFire_Frame:Hide();
        MNinsectSwarm_Frame:Hide();
        MNstarSurge_Frame:Hide();
    else
        MageNugMoonkinOptionFrame_CheckButton:SetChecked(false);
        if(MageNuggetsClassic.moonkinCombat == false) then
            MageNugMoonkin_Frame:Show();
            MNmoonFire_Frame:Show();
            MNinsectSwarm_Frame:Show();
            MNstarSurge_Frame:Show();
        end
    end
    if (MageNuggetsClassic.moonkinCombat == nil) then
        MageNuggetsClassic.moonkinCombat = false;
    end
    if (MageNuggetsClassic.moonkinCombat == true) then
        MageNugMoonkinOptionFrame_CheckButton1:SetChecked(true);
    else
        MageNugMoonkinOptionFrame_CheckButton1:SetChecked(false);
    end
    if (MageNuggetsClassic.moonkinMin == nil) then
        MageNuggetsClassic.moonkinMin = false;
    end
    if (MageNuggetsClassic.moonkinMin == true) then
        MageNugMoonkinOptionFrame_CheckButtonMin:SetChecked(true);
    else
        MageNugMoonkinOptionFrame_CheckButtonMin:SetChecked(false);
    end
    if (MageNuggetsClassic.moonkinSize == nil) then
        MageNugMoonkinOptionFrame_Slider:SetValue(3)
    else
        MageNugMoonkinOptionFrame_Slider:SetValue(MageNuggetsClassic.moonkinSize)
    end
    if (MageNuggetsClassic.treantSoundTog == nil) then
        MageNuggetsClassic.treantSoundTog = true;
    end
    if (MageNuggetsClassic.treantSoundTog == true) then
        MageNugMoonkinOptionFrame_CheckButton2:SetChecked(true);
    else
        MageNugMoonkinOptionFrame_CheckButton2:SetChecked(false);
    end
    if (MageNuggetsClassic.treantSound2 == nil) or (MageNuggetsClassic.treantSound2 == "") then
        MageNugMoonkinOptionFrame_SoundEditBox:SetText("mirror.mp3")
    else
        MageNugMoonkinOptionFrame_SoundEditBox:SetText(MageNuggetsClassic.treantSound2)
    end
    if (MageNuggetsClassic.moonkinCombatText == nil)then
        MageNuggetsClassic.moonkinCombatText = true
    end
    if (MageNuggetsClassic.moonkinCombatText == true) then
        MageNugMoonkinOptionFrame_CheckButton3:SetChecked(true);
    else
        MageNugMoonkinOptionFrame_CheckButton3:SetChecked(false);
    end
    if (MageNuggetsClassic.innervatNotify == nil) or (MageNuggetsClassic.innervatNotify == "") then
        MageNugMoonkinOptionFrame_InnervateEditBox:SetText("Innervate Cast On You!")
    else
        MageNugMoonkinOptionFrame_InnervateEditBox:SetText(MageNuggetsClassic.innervatNotify)
    end
    if (MageNuggetsClassic.moonkinAnchorTog == nil) then
        MageNuggetsClassic.moonkinAnchorTog = true;
    end
    if(MageNuggetsClassic.moonkinAnchorTog == true)then
        MageNugMoonkinOptionFrame_CheckButtonAnchor:SetChecked(true)
    else
        MageNugMoonkinOptionFrame_CheckButtonAnchor:SetChecked(false)
    end
    soundPlayed = false;
    ------------------------------
    MageNugPolyFrame:Hide();
    MageNugBFProcFrame:Hide();
    MageNugProcFrame:Hide();
    MageNugPyroclasmProcFrame:Hide();
    MageNugMBProcFrame:Hide();
    MageNugFoFProcFrame:Hide();
    MageNugAB_Frame:Hide();
    paralysisId, _, _, _, _, _, _, _, _ = GetSpellInfo(115078);
    shackleId, _, _, _, _, _, _, _, _ = GetSpellInfo(9484);
    iceBlockId, _, _, _, _, _, _, _, _ = GetSpellInfo(45438);
    livingBombId, _, _, _, _, _, _, _, _ = GetSpellInfo(44457);
    netherTempestId, _, _, _, _, _, _, _, _ = GetSpellInfo(114923);
    icyVeinsId, _, _, _, _, _, _, _, _ = GetSpellInfo(12472);
    polyPigId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
    polySheepId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
    polyTurtleId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
    polyRabbitId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
    polyCatId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
    frostboltId, _, _, _, _, _, _, _, _ = GetSpellInfo(42842);
    frostfireId, _, _, _, _, _, _, _, _ = GetSpellInfo(47610);
    conecoldId, _, _, _, _, _, _, _, _ = GetSpellInfo(42931);
    blastwaveId, _, _, _, _, _, _, _, _ = GetSpellInfo(42945);
    judgementjustId, _, _, _, _, _, _, _, _ = GetSpellInfo(53696);
    infectedwoundsId, _, _, _, _, _, _, _, _ = GetSpellInfo(48485);
    thunderclapId, _, _, _, _, _, _, _, _ = GetSpellInfo(47502);
    deadlythrowId, _, _, _, _, _, _, _, _ = GetSpellInfo(48674);
    frostshockId, _, _, _, _, _, _, _, _ = GetSpellInfo(49236);
    chilledId, _, _, _, _, _, _, _, _ = GetSpellInfo(7321);
    mindflayId, _, _, _, _, _, _, _, _ = GetSpellInfo(48156);
    impactId, _, _, _, _, _, _, _, _ = GetSpellInfo(64343);


    MageNugz_MinimapButton_Move()

    MnClickThrough()
    MNmoonkinAnchorToggle()
    incombat = 0;

    if(MageNuggetsClassic_Frames.frostbomb_point == nil) then
        MageNuggetsClassic_Frames.frostbomb_point = "CENTER";
    end
    if(MageNuggetsClassic_Frames.frostbomb_relativePoint == nil) then
        MageNuggetsClassic_Frames.frostbomb_relativePoint = "CENTER";
    end
    if(MageNuggetsClassic_Frames.frostbomb_xOfs == nil) then
        MageNuggetsClassic_Frames.frostbomb_xOfs = 0;
    end
    if(MageNuggetsClassic_Frames.frostbomb_yOfs == nil) then
        MageNuggetsClassic_Frames.frostbomb_yOfs = 0;
    end

    if(MageNuggetsClassic_Frames.hu_point == nil) then
        MageNuggetsClassic_Frames.hu_point = "CENTER";
    end
    if(MageNuggetsClassic_Frames.hu_relativePoint == nil) then
        MageNuggetsClassic_Frames.hu_relativePoint = "CENTER";
    end
    if(MageNuggetsClassic_Frames.hu_xOfs == nil) then
        MageNuggetsClassic_Frames.hu_xOfs = 0;
    end
    if(MageNuggetsClassic_Frames.hu_yOfs == nil) then
        MageNuggetsClassic_Frames.hu_yOfs = 0;
    end

    if(MageNuggetsClassic_Frames.pyroclasm_point == nil) then
        MageNuggetsClassic_Frames.pyroclasm_point = "CENTER";
    end
    if(MageNuggetsClassic_Frames.pyroclasm_relativePoint == nil) then
        MageNuggetsClassic_Frames.pyroclasm_relativePoint = "CENTER";
    end
    if(MageNuggetsClassic_Frames.pyroclasm_xOfs == nil) then
        MageNuggetsClassic_Frames.pyroclasm_xOfs = 0;
    end
    if(MageNuggetsClassic_Frames.pyroclasm_yOfs == nil) then
        MageNuggetsClassic_Frames.pyroclasm_yOfs = 0;
    end

end

function MageNuggetsClassicSoundOptionsOnLoad()
    if (MageNuggetsClassic.miSound2 == nil) or (MageNuggetsClassic.miSound2 == "") or (MageNuggetsClassic.miSound2 == "mirror.ogg") then
        MageNugSoundOptionFrame_MISoundEditBox:SetText("mirror.mp3")
    else
        MageNugSoundOptionFrame_MISoundEditBox:SetText(MageNuggetsClassic.miSound2)
    end
    if (MageNuggetsClassic.procSound2 == nil) or (MageNuggetsClassic.procSound2 == "") or (MageNuggetsClassic.procSound2 == "proc.ogg") then
        MageNugSoundOptionFrame_ProcSoundEditBox:SetText("proc.mp3")
    else
        MageNugSoundOptionFrame_ProcSoundEditBox:SetText(MageNuggetsClassic.procSound2)
    end
    if (MageNuggetsClassic.miSoundToggle == true) or (MageNuggetsClassic.miSoundToggle == nil) then
        MageNugSoundOptionFrame_MICheckButton:SetChecked(true);
        MageNuggetsClassic.miSoundToggle = true;
    else
        MageNugSoundOptionFrame_MICheckButton:SetChecked(false);
    end
    if (MageNuggetsClassic.procSoundToggle == true) or (MageNuggetsClassic.procSoundToggle == nil) then
        MageNugSoundOptionFrame_ProcCheckButton:SetChecked(true);
        MageNuggetsClassic.procSoundToggle = true;
    else
        MageNugSoundOptionFrame_ProcCheckButton:SetChecked(false);
    end
    if (MageNuggetsClassic.polySound2 == nil) or (MageNuggetsClassic.polySound2 == "") or (MageNuggetsClassic.polySound2 == "sheep.ogg") then
        MageNugSoundOptionFrame_PolySoundEditBox:SetText("sheep.mp3")
    else
        MageNugSoundOptionFrame_PolySoundEditBox:SetText(MageNuggetsClassic.polySound2)
    end
    if (MageNuggetsClassic.polySoundToggle == true) or (MageNuggetsClassic.polySoundToggle == nil) then
        MageNugSoundOptionFrame_PolyCheckButton:SetChecked(true);
        MageNuggetsClassic.polySoundToggle = true;
    else
        MageNugSoundOptionFrame_PolyCheckButton:SetChecked(false);
    end

    if (MageNuggetsClassic.ABSound2 == nil) or (MageNuggetsClassic.ABSound2 == "") or (MageNuggetsClassic.ABSound2 == "impact.ogg") then
        MageNugSoundOptionFrame_ABSoundEditBox:SetText("impact.mp3")
    else
        MageNugSoundOptionFrame_ABSoundEditBox:SetText(MageNuggetsClassic.ABSound2)
    end
    if (MageNuggetsClassic.ABSoundToggle == true) or (MageNuggetsClassic.ABSoundToggle == nil) then
        MageNugSoundOptionFrame_ABCheckButton:SetChecked(true);
        MageNuggetsClassic.ABSoundToggle = true;
    else
        MageNugSoundOptionFrame_ABCheckButton:SetChecked(false);
    end

    if (MageNuggetsClassic.hsSound2 == nil) or (MageNuggetsClassic.hsSound2 == "") or (MageNuggetsClassic.hsSound2 == "hotstreak.ogg") then
        MageNugSoundOptionFrame_HotStreakSoundEditBox:SetText("hotstreak.mp3")
    else
        MageNugSoundOptionFrame_HotStreakSoundEditBox:SetText(MageNuggetsClassic.hsSound2)
    end
    if (MageNuggetsClassic.hsSoundToggle == true) or (MageNuggetsClassic.hsSoundToggle == nil) then
        MageNugSoundOptionFrame_HotStreakCheckButton:SetChecked(true);
        MageNuggetsClassic.hsSoundToggle = true;
    else
        MageNugSoundOptionFrame_HotStreakCheckButton:SetChecked(false);
    end
    if (MageNuggetsClassic.impactSound2 == nil) or (MageNuggetsClassic.impactSound2 == "") or (MageNuggetsClassic.impactSound2 == "impact.ogg") then
        MageNugSoundOptionFrame_ImpactSoundEditBox:SetText("impact.mp3")
    else
        MageNugSoundOptionFrame_ImpactSoundEditBox:SetText(MageNuggetsClassic.impactSound2)
    end
    if (MageNuggetsClassic.impactSoundToggle == true) or (MageNuggetsClassic.impactSoundToggle == nil) then
        MageNugSoundOptionFrame_ImpactCheckButton:SetChecked(true);
        MageNuggetsClassic.impactSoundToggle = true;
    else
        MageNugSoundOptionFrame_ImpactCheckButton:SetChecked(false);
    end
    if (MageNuggetsClassic.fofSound2 == nil) or (MageNuggetsClassic.fofSound2 == "") or (MageNuggetsClassic.fofSound2 == "fof.ogg") then
        MageNugSoundOptionFrame_FoFSoundEditBox:SetText("fof.mp3")
    else
        MageNugSoundOptionFrame_FoFSoundEditBox:SetText(MageNuggetsClassic.fofSound2)
    end
    if (MageNuggetsClassic.fofSoundToggle == true) or (MageNuggetsClassic.fofSoundToggle == nil) then
        MageNugSoundOptionFrame_FoFCheckButton:SetChecked(true);
        MageNuggetsClassic.fofSoundToggle = true;
    else
        MageNugSoundOptionFrame_FoFCheckButton:SetChecked(false);
    end
    if (MageNuggetsClassic.brainfreezeSound2 == nil) or (MageNuggetsClassic.brainfreezeSound2 == "") or (MageNuggetsClassic.brainfreezeSound2 == "brainfreeze.ogg") then
        MageNugSoundOptionFrame_BrainFreezeSoundEditBox:SetText("brainfreeze.mp3")
    else
        MageNugSoundOptionFrame_BrainFreezeSoundEditBox:SetText(MageNuggetsClassic.brainfreezeSound2)
    end
    if (MageNuggetsClassic.brainfreezeSoundToggle == true) or (MageNuggetsClassic.brainfreezeSoundToggle == nil) then
        MageNugSoundOptionFrame_BrainFreezeCheckButton:SetChecked(true);
        MageNuggetsClassic.brainfreezeSoundToggle = true;
    else
        MageNugSoundOptionFrame_BrainFreezeCheckButton:SetChecked(false);
    end
    if (MageNuggetsClassic.cauterizeSound2 == nil) or (MageNuggetsClassic.cauterizeSound2 == "") or (MageNuggetsClassic.cauterizeSound2 == "toasty.ogg") then
        MageNugSoundOptionFrame_CauterizeSoundEditBox:SetText("toasty.mp3")
    else
        MageNugSoundOptionFrame_CauterizeSoundEditBox:SetText(MageNuggetsClassic.cauterizeSound2)
    end
    if (MageNuggetsClassic.cauterizeSoundToggle == true) or (MageNuggetsClassic.cauterizeSoundToggle == nil) then
        MageNugSoundOptionFrame_CauterizeCheckButton:SetChecked(true);
        MageNuggetsClassic.cauterizeSoundToggle = true;
    else
        MageNugSoundOptionFrame_CauterizeCheckButton:SetChecked(false);
    end
    if (MageNuggetsClassic.timewarpSound2 == nil) or (MageNuggetsClassic.timewarpSound2 == "") or (MageNuggetsClassic.timewarpSound2 == "timewarp.ogg") then
        MageNugSoundOptionFrame_TimeWarpSoundEditBox:SetText("timewarp.mp3")
    else
        MageNugSoundOptionFrame_TimeWarpSoundEditBox:SetText(MageNuggetsClassic.timewarpSound2)
    end
    if (MageNuggetsClassic.timewarpSoundToggle == true) or (MageNuggetsClassic.timewarpSoundToggle == nil) then
        MageNugSoundOptionFrame_TimeWarpCheckButton:SetChecked(true);
        MageNuggetsClassic.timewarpSoundToggle = true;
    else
        MageNugSoundOptionFrame_TimeWarpCheckButton:SetChecked(false);
    end
end

--
function MNsimpleUItoggle()
    local isChecked = MageNugOption2Frame_SimpleUICheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggetsClassic.simpleUiToggle = true;
        MageNugProcFrameTextureBorder:SetTexture();
        MageNugBFProcFrameTextureBorder:SetTexture();
        MageNugProcHUFrameTextureBorder:SetTexture();
        MageNugPyroclasmProcFrameTextureBorder:SetTexture();
        MageNugCauterizeFrameTextureBorder:SetTexture();
        MageNugPolyFrameTextureBorder:SetTexture();
        MageNugFoFProcFrameTextureBorder:SetTexture();
        MageNugMBProcFrameTextureBorder:SetTexture();
    else
        MageNuggetsClassic.simpleUiToggle = false;
        MageNugProcFrameTextureBorder:SetTexture("Interface\\UNITPOWERBARALT\\Fire_Horizontal_Frame");
        MageNugPyroclasmProcFrameTextureBorder:SetTexture("Interface\\UNITPOWERBARALT\\Fire_Horizontal_Frame");
        MageNugBFProcFrameTextureBorder:SetTexture("Interface\\UNITPOWERBARALT\\Water_Horizontal_Frame");
        MageNugProcHUFrameTextureBorder:SetTexture("Interface\\UNITPOWERBARALT\\Fire_Horizontal_Frame");
        MageNugCauterizeFrameTextureBorder:SetTexture("Interface\\UNITPOWERBARALT\\Fire_Horizontal_Frame");
        MageNugPolyFrameTextureBorder:SetTexture("Interface\\UNITPOWERBARALT\\MetalEternium_Horizontal_Frame");
        MageNugFoFProcFrameTextureBorder:SetTexture("Interface\\UNITPOWERBARALT\\Ice_Horizontal_Frame");
        MageNugMBProcFrameTextureBorder:SetTexture("Interface\\GMChatFrame\\UI-GMStatusFrame-Pulse");
    end
end
--
function MNMinimapButtonToggle()
    local mini = MageNugOption2Frame_MinimapCheckButton:GetChecked();
    if (mini == true) then
        MageNuggetsClassic.minimapToggle = false;
        MageNug_MinimapFrame:Hide();
    else
        MageNuggetsClassic.minimapToggle = true;
        MageNug_MinimapFrame:Show();
    end
end
--
function MNNovaToggle() -- ice nova supernova
    local mini = MageNugOptionsFrame_CheckButtonNova:GetChecked();
    if (mini == true) then
        MageNuggetsClassic.novaMonitorToggle = false;
        MageNugNova_Frame:Hide();
    else
        MageNuggetsClassic.novaMonitorToggle = true;
    end
end
--
function HideSSMonitorToggle() -- Spellsteal Monitor Toggle
    local stealMonitorChecked = MageNugOptionsFrame_CheckButton2:GetChecked();
    if (stealMonitorChecked == true) then
	    MageNuggetsClassic.ssMonitorToggle = false;
    else
        MageNuggetsClassic.ssMonitorToggle = true;
    end
end

function MNmessagesToggle() --slowfall notify Toggle
    local msgTog = MageNugMsgOptionFrame_CheckButton:GetChecked();
    if (msgTog == true) then
	    MageNuggetsClassic.msgToggle = true;
    else
        MageNuggetsClassic.msgToggle = false;
    end
end

function MNpainSupNotifyToggle() -- pain suppression notify toggle
    local msgTog = MageNugPriestOptionFrame_CheckButton2:GetChecked();
    if (msgTog == true) then
	    MageNuggetsClassic.painSupToggle = true;
    else
        MageNuggetsClassic.painSupToggle = false;
    end
end

function MNgspiritNotifyToggle() -- g spirit notify toggle
    local msgTog = MageNugPriestOptionFrame_CheckButton3:GetChecked();
    if (msgTog == true) then
	    MageNuggetsClassic.gspiritToggle = true;
    else
        MageNuggetsClassic.gspiritToggle = false;
    end
end


function MNpowerInfNotifyToggle() -- power inf notify toggle
    local msgTog = MageNugPriestOptionFrame_CheckButton0:GetChecked();
    if (msgTog == true) then
	    MageNuggetsClassic.powerInfToggle = true;
    else
        MageNuggetsClassic.powerInfToggle = false;
    end
end

function MNfocusMagicNotifyToggle() -- Focus magic notify toggle
    local msgTog = MageNugMsgOptionFrame_CheckButton2:GetChecked();
    if (msgTog == true) then
	    MageNuggetsClassic.symbiosisnToggle = true;
    else
        MageNuggetsClassic.symbiosisnToggle = false;
    end
end

function MNfocusMagicThanksToggle() -- Focus magic thanks toggle
    local msgTog = MageNugMsgOptionFrame_CheckButton3:GetChecked();
    if (msgTog == true) then
	    MageNuggetsClassic.symbiosistyToggle = true;
    else
        MageNuggetsClassic.symbiosistyToggle = false;
    end
end

function MNinnervateThanksToggle() -- innervate thanks toggle
    local msgTog = MageNugMsgOptionFrame_CheckButton4:GetChecked();
    if (msgTog == true) then
	    MageNuggetsClassic.innertyToggle = true;
    else
        MageNuggetsClassic.innertyToggle = false;
    end
end
function MNpowerInfusionTyToggle() -- Power infusion thanks toggle
    local msgTog = MageNugMsgOptionFrame_CheckButton5:GetChecked();
    if (msgTog == true) then
	    MageNuggetsClassic.pityToggle = true;
    else
        MageNuggetsClassic.pityToggle = false;
    end
end
function MNdarkIntentTyToggle() -- dark intent thanks toggle
    local msgTog = MageNugMsgOptionFrame_CheckButton6:GetChecked();
    if (msgTog == true) then
	    MageNuggetsClassic.dityToggle = true;
    else
        MageNuggetsClassic.dityToggle = false;
    end
end

function MNCauterizeToggle()
    local isChecked = CauterizeCheckButton:GetChecked();
    if (isChecked == true) then
	    MageNuggetsClassic.cauterizeToggle = true;
    else
        MageNuggetsClassic.cauterizeToggle = false;
    end
end

function MageProcNoteToggle() -- Mage Proc Notification Toggle
    local cNotifyChecked = MageNugOptionsFrame_CheckButton3:GetChecked();
    if (cNotifyChecked == true) then
	    MageNuggetsClassic.mageProcToggle = false;
    else
        MageNuggetsClassic.mageProcToggle = true;
    end
end

function cameraZoomToggle() -- Camera Zoom Out Toggle
    local camZoomChecked = MageNugOption2Frame_CameraCheckButton:GetChecked();
    if (camZoomChecked == true) then
        ConsoleExec("cameraDistanceMax 15");
        MageNuggetsClassic.camZoomTogg = false;
    else
        ConsoleExec("cameraDistanceMax 50");
        MageNuggetsClassic.camZoomTogg = true;
    end
end

function MirrorImageSoundToggle() -- Mirror Image Sound Toggle
    local miChecked = MageNugSoundOptionFrame_MICheckButton:GetChecked();
    if (miChecked == true) then
        MageNuggetsClassic.miSoundToggle = true;
    else
        MageNuggetsClassic.miSoundToggle = false;
    end
end

function ProcSoundToggle() -- Proc Sound Toggle
    local procChecked = MageNugSoundOptionFrame_ProcCheckButton:GetChecked();
    if (procChecked == true) then
        MageNuggetsClassic.procSoundToggle = true;
    else
        MageNuggetsClassic.procSoundToggle = false;
    end
end

function PolySoundToggle() -- Poly Sound Toggle
    local isChecked = MageNugSoundOptionFrame_PolyCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggetsClassic.polySoundToggle = true;
    else
        MageNuggetsClassic.polySoundToggle = false;
    end
end

function BlastStackSoundToggle() -- Arcane Blast \ Stack Sound Toggle
    local isChecked = MageNugSoundOptionFrame_ABCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggetsClassic.ABSoundToggle = true;
    else
        MageNuggetsClassic.ABSoundToggle = false;
    end
end

function HotStreakSoundToggle() -- HS Sound Toggle
    local isChecked = MageNugSoundOptionFrame_HotStreakCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggetsClassic.hsSoundToggle = true;
    else
        MageNuggetsClassic.hsSoundToggle = false;
    end
end

function CauterizeSoundToggle() -- Cauterize Sound Toggle
    local isChecked = MageNugSoundOptionFrame_CauterizeCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggetsClassic.cauterizeSoundToggle = true;
    else
        MageNuggetsClassic.cauterizeSoundToggle = false;
    end
end

function TimeWarpSoundToggle() -- time warp Sound Toggle
    local isChecked = MageNugSoundOptionFrame_TimeWarpCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggetsClassic.timewarpSoundToggle = true;
    else
        MageNuggetsClassic.timewarpSoundToggle = false;
    end
end

function ImpactSoundToggle() -- Impact Sound Toggle
    local isChecked = MageNugSoundOptionFrame_ImpactCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggetsClassic.impactSoundToggle = true;
    else
        MageNuggetsClassic.impactSoundToggle = false;
    end
end

function FoFSoundToggle() -- FoF Sound Toggle
    local isChecked = MageNugSoundOptionFrame_FoFCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggetsClassic.fofSoundToggle = true;
    else
        MageNuggetsClassic.fofSoundToggle = false;
    end
end

function BrainFreezeSoundToggle() --Brain Freeze Sound Toggle
    local isChecked = MageNugSoundOptionFrame_BrainFreezeCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggetsClassic.brainfreezeSoundToggle = true;
    else
        MageNuggetsClassic.brainfreezeSoundToggle = false;
    end
end

function MirrorImagToggle() -- Mirror Image Timer Toggle
    local mirrorChecked = MageNugOptionsFrame_CheckButton6:GetChecked();
    if (mirrorChecked == true) then
        MageNuggetsClassic.mirrorImageToggle = false;
    else
        MageNuggetsClassic.mirrorImageToggle = true;
    end
end


function MNabCastTimeToggle() -- AB Cast Time Toggle
    local abcChecked = MageNugOptionsFrame_ABcastCheckButton:GetChecked();
    if (abcChecked == true) then
        MageNuggetsClassic.abCastTimeToggle = true;
        MNabCast_Frame:Show();
    else
        MageNuggetsClassic.abCastTimeToggle = false;
        MNabCast_Frame:Hide();
    end
end

function MageProcMonitorToggle()
    local mpChecked = MageNugOptionsFrame_CheckButton11:GetChecked();
    if (mpChecked == true) then
        MageNuggetsClassic.procMonitorToggle = false;
    else
        MageNuggetsClassic.procMonitorToggle = true;
    end
end

function MNArcaneBlastToggle()
    local abChecked = MageNugOptionsFrame_CheckButton13:GetChecked();
    if (abChecked == true) then
        MageNuggetsClassic.arcaneBlastToggle = false;
    else
        MageNuggetsClassic.arcaneBlastToggle = true;
    end
end

function MNpolyToggle()
    local polyChecked = MageNugOptionsFrame_CheckButton14:GetChecked();
    if (polyChecked == true) then
        MageNuggetsClassic.polyToggle = false;
    else
        MageNuggetsClassic.polyToggle = true;
    end
end

function MnClickThrough()
    local clickChecked = MageNugOption2Frame_ClickThruCheckButton:GetChecked();
    if (clickChecked == true) then
        MageNuggetsClassic.clickthru = true;
        MNSpellStealFocus_Frame:EnableMouse(false);
        MageNugIgnite_Frame:EnableMouse(false)
        MageNugCauterize_Frame:EnableMouse(false);
        MageNugAB_Frame:EnableMouse(false)
        MNabCast_Frame:EnableMouse(false)
        MageNugProcFrame:EnableMouse(false)
        MageNugPyroclasmProcFrame:EnableMouse(false)
        MageNugProcHUFrame:EnableMouse(false)
        MageNugPolyFrame:EnableMouse(false)
        MageNugBFProcFrame:EnableMouse(false)
        MageNugMBProcFrame:EnableMouse(false)
        MageNugFoFProcFrame:EnableMouse(false)
        MNSpellSteal_Frame:EnableMouse(false)
        MageNugMI_Frame:EnableMouse(false)
        MageNugMoonkin_Frame:EnableMouse(false)
        MNmoonFire_Frame:EnableMouse(false)
        MNinsectSwarm_Frame:EnableMouse(false)
        MNstarSurge_Frame:EnableMouse(false)
    else
        MageNuggetsClassic.clickthru = false;
        MNSpellStealFocus_Frame:EnableMouse(true);
        MageNugIgnite_Frame:EnableMouse(true)
        MageNugCauterize_Frame:EnableMouse(true);
        MageNugAB_Frame:EnableMouse(true)
        MNabCast_Frame:EnableMouse(true)
        MageNugProcFrame:EnableMouse(true)
        MageNugPyroclasmProcFrame:EnableMouse(true)
        MageNugProcHUFrame:EnableMouse(true)
        MageNugPolyFrame:EnableMouse(true)
        MageNugBFProcFrame:EnableMouse(true)
        MageNugMBProcFrame:EnableMouse(true)
        MageNugFoFProcFrame:EnableMouse(true)
        MNSpellSteal_Frame:EnableMouse(true)
        MageNugMI_Frame:EnableMouse(true)
        MageNugMoonkin_Frame:EnableMouse(true)
        MNmoonFire_Frame:EnableMouse(true)
        MNinsectSwarm_Frame:EnableMouse(true)
        MNstarSurge_Frame:EnableMouse(true)
    end
end

function ShowConfigFrames() --Shows frames for 120 seconds
    previewMnFrames = true;
    if (MageNuggetsClassic.ssMonitorToggle == true) then
        spellStealTog = 120;
        MNSpellSteal_Frame:Show();
        MNSpellStealFocus_Frame:Show();
    end
    mirrorImageTime = 120;
    MageNugMI_Frame:Show();
    MageNugNova_Frame:Show();
    MageNugIgnite_Frame:Show();
    polyTimer = 120
    MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph")
    MageNugPolyFrame:Show();
    mageImpProgMonTime = 120;
    MageNugBFProcFrameText:SetText("|cffFFFFFF".."BRAIN FREEZE!")
    MageNugBFProcFrame:Show();
    MageNugProcFrameText:SetText("|cffFF0000".."HOT STREAK!");
    MageNugProcFrame:Show();
    MageNugPyroclasmProcFrameText:SetText("|cffFF0000".."PYROCLASM");
    MageNugPyroclasmProcFrame:Show();
    MageNugProcHUFrameText:SetText("|cffFFCC00".."HEATING UP!");
    MageNugProcHUFrame:Show();
    MageNugMBProcFrameText:SetText("|cffFF33FF".."CLEARCAST!")
    MageNugMBProcFrame:Show();
    MageNugFoFProcFrameText:SetText("|cffFFFFFF".."Fingers Of Frost")
    MageNugFoFProcFrame:Show();
    cauterizeTime = 120;
    MageNugCauterize_Frame:Show();
    abProgMonTime = 120;
    MageNugAB_Frame:Show();
    clearcastTime = 120;
    MageNugCauterizeFrame:Show();
end

function HideConfigFrames()
    previewMnFrames = false;
    MageNugCauterize_Frame:Hide();
    MNSpellSteal_Frame:Hide();
    MNSpellStealFocus_Frame:Hide();
    MageNugMI_Frame:Hide();
    MageNugPolyFrame:Hide();
    MageNugIgnite_Frame:Hide();
    MageNugBFProcFrame:Hide();
    MageNugProcFrame:Hide();
    MageNugPyroclasmProcFrame:Hide();
    MageNugProcHUFrame:Hide();
    MageNugMBProcFrame:Hide();
    MageNugFoFProcFrame:Hide();
    MageNugAB_Frame:Hide();
    MageNugCauterizeFrame:Hide();
    MageNugNova_Frame:Hide();
end


function LockFramesToggle()
    local flChecked = MageNugOption2Frame_LockFramesCheckButton:GetChecked();
    if (flChecked == true) then
        MageNuggetsClassic.lockFrames = true;
    else
        MageNuggetsClassic.lockFrames = false;
    end
end

function ConsoleTextToggle()
    local ctChecked = MageNugOption2Frame_ConsoleTextCheckButton:GetChecked();
    if (ctChecked == true) then
        MageNuggetsClassic.consoleTextEnabled = false;
    else
        MageNuggetsClassic.consoleTextEnabled = true;
    end
end

function MNtoolTipToggle()
    local ttChecked = MageNugOption2Frame_CheckButtonTT:GetChecked();
    if (ttChecked == true) then
        MageNuggetsClassic.toolTips = true;
    else
        MageNuggetsClassic.toolTips = false;
    end
end


function MageNugArcaneBlastSize()
    local tempInt = MageNugOptionsFrame_Slider3:GetValue()

    if not MageNugOptionsFrame_Slider3._onsetting then
        MageNugOptionsFrame_Slider3._onsetting = true
        MageNugOptionsFrame_Slider3:SetValue(MageNugOptionsFrame_Slider3:GetValue())
        tempInt = MageNugOptionsFrame_Slider3:GetValue()
        MageNugOptionsFrame_Slider3._onsetting = false
    else return end

    if (tempInt == 0) then
        MageNugNova_Frame:SetScale(0.7);
        MageNugAB_Frame:SetScale(0.7);
        MageNuggetsClassic.arcaneBlastSize = 0;
    elseif (tempInt == 1) then
        MageNugNova_Frame:SetScale(0.8);
        MageNugAB_Frame:SetScale(0.8);
        MageNuggetsClassic.arcaneBlastSize = 1;
    elseif (tempInt == 2) then
        MageNugNova_Frame:SetScale(0.9);
        MageNugAB_Frame:SetScale(0.9);
        MageNuggetsClassic.arcaneBlastSize = 2;
    elseif (tempInt == 3) then
        MageNugNova_Frame:SetScale(1.0);
        MageNugAB_Frame:SetScale(1.0);
        MageNuggetsClassic.arcaneBlastSize = 3;
    elseif (tempInt == 4) then
        MageNugNova_Frame:SetScale(1.1);
        MageNugAB_Frame:SetScale(1.1);
        MageNuggetsClassic.arcaneBlastSize = 4;
    elseif (tempInt == 5) then
        MageNugNova_Frame:SetScale(1.2);
        MageNugAB_Frame:SetScale(1.2);
        MageNuggetsClassic.arcaneBlastSize = 5;
    elseif (tempInt == 6) then
        MageNugNova_Frame:SetScale(1.3);
        MageNugAB_Frame:SetScale(1.3);
        MageNuggetsClassic.arcaneBlastSize = 6;
    elseif (tempInt == 7) then
        MageNugNova_Frame:SetScale(1.5);
        MageNugAB_Frame:SetScale(1.5);
        MageNuggetsClassic.arcaneBlastSize = 7;
    elseif (tempInt == 8) then
        MageNugNova_Frame:SetScale(1.7);
        MageNugAB_Frame:SetScale(1.7);
        MageNuggetsClassic.arcaneBlastSize = 8;
    elseif (tempInt == 9) then
        MageNugNova_Frame:SetScale(1.9);
        MageNugAB_Frame:SetScale(1.9);
        MageNuggetsClassic.arcaneBlastSize = 9;
    elseif (tempInt == 10) then
        MageNugNova_Frame:SetScale(2.1);
        MageNugAB_Frame:SetScale(2.1);
        MageNuggetsClassic.arcaneBlastSize = 10;
    end
end
--
function updatePortalMenu(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
        local startTime, duration, enable = GetItemCooldown(6948);
        local hearthCooldown = startTime + duration - GetTime();
        if(hearthCooldown <= 0)then
            hearthCooldown = '';
            MageNugHordeFrameText3:SetText("");
            MageNugAlliFrameText3:SetText("");
        elseif(hearthCooldown > 60)then
            hearthCooldown = hearthCooldown / 60;
            MageNugHordeFrameText3:SetText("|cffffffff"..RoundZero(hearthCooldown).."m");
            MageNugAlliFrameText3:SetText("|cffffffff"..RoundZero(hearthCooldown).."m");
        else
            MageNugHordeFrameText3:SetText("|cffffffff"..RoundZero(hearthCooldown).."s");
            MageNugAlliFrameText3:SetText("|cffffffff"..RoundZero(hearthCooldown).."s");
        end


        local ghTime, ghDuration, ghenable = GetItemCooldown(110560);
        local garrisonHearthCooldown = RoundZero(ghTime + ghDuration - GetTime());
        if(garrisonHearthCooldown <= 0)then
            garrisonHearthCooldown = '';
            MageNugHordeFrameText4:SetText("");
            MageNugAlliFrameText4:SetText("");
        elseif(garrisonHearthCooldown > 60)then
            garrisonHearthCooldown = garrisonHearthCooldown / 60;
            MageNugHordeFrameText4:SetText("|cffffffff"..RoundZero(garrisonHearthCooldown).."m");
            MageNugAlliFrameText4:SetText("|cffffffff"..RoundZero(garrisonHearthCooldown).."m");
        else
            MageNugHordeFrameText4:SetText("|cffffffff"..RoundZero(garrisonHearthCooldown).."s");
            MageNugAlliFrameText4:SetText("|cffffffff"..RoundZero(garrisonHearthCooldown).."s");
        end

        self.TimeSinceLastUpdate = 0;
    end
end
--
function loadMageNuggetVariables_OnLoadEvent()
     mnplayerClass, mnenglishClass = UnitClass("player");
    if((mnenglishClass == 'WARRIOR') or (mnenglishClass == 'MONK') or (mnenglishClass == 'DEMONHUNTER') or (mnenglishClass == 'ROGUE') or (mnenglishClass == 'DEATHKNIGHT') or (mnenglishClass == 'PALADIN') or (mnenglishClass == 'HUNTER')) then
        MageNuggetsClassic.ssMonitorToggle = false;
        MageNuggetsClassic.igniteTog = false;
        MageNuggetsClassic.mageProcToggle = false;
        MageNuggetsClassic.camZoomTogg = false;
        MageNuggetsClassic.mirrorImageToggle = false;
        MageNuggetsClassic.procMonitorToggle = false;
        MageNuggetsClassic.consoleTextEnabled = false;
        MageNuggetsClassic.arcaneBlastToggle = false;
        MageNuggetsClassic.minimapToggle = false;
        MageNuggetsClassic.moonkinTog = true;
        MageNugMoonkin_Frame:Hide()
        MNmoonFire_Frame:Hide();
        MNinsectSwarm_Frame:Hide();
        MNstarSurge_Frame:Hide();
    end
    if(mnenglishClass == 'WARLOCK') then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff "..magenugVer.." loaded! Some Options Disabled (Class:"..UnitClass("Player")..")")
        MageNuggetsClassic.igniteTog = false;
        MageNuggetsClassic.ssMonitorToggle = false;
        MageNuggetsClassic.mageProcToggle = false;
        MageNuggetsClassic.mirrorImageToggle = false;
        MageNuggetsClassic.procMonitorToggle = false;
        MageNuggetsClassic.minimapToggle = false;
        MageNuggetsClassic.moonkinTog = true;
        MageNugMoonkin_Frame:Hide()
        MNmoonFire_Frame:Hide();
        MNinsectSwarm_Frame:Hide();
        MNstarSurge_Frame:Hide();
    end
    if(mnenglishClass == 'SHAMAN')then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff "..magenugVer.." loaded! Some Options Disabled (Class:"..UnitClass("Player")..")")
        MageNuggetsClassic.igniteTog = false;
        MageNuggetsClassic.mageProcToggle = false;
        MageNuggetsClassic.mirrorImageToggle = false;
        MageNuggetsClassic.procMonitorToggle = false;
        MageNuggetsClassic.minimapToggle = false;
        MageNuggetsClassic.moonkinTog = true;
        MageNugMoonkin_Frame:Hide()
        MNmoonFire_Frame:Hide();
        MNinsectSwarm_Frame:Hide();
        MNstarSurge_Frame:Hide();
        MNSpellSteal_FrameTitleText:SetText("|cffffffffPURGEABLE")
    end
    if(mnenglishClass == 'PRIEST') then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff "..magenugVer.." loaded! Some Options Disabled (Class:"..UnitClass("Player")..")")
        MageNuggetsClassic.igniteTog = false;
        MNSpellSteal_FrameTitleText:SetText("|cff33ccffD I S P E L");
        MageNuggetsClassic.mageProcToggle = false;
        MageNuggetsClassic.mirrorImageToggle = false;
        MageNuggetsClassic.procMonitorToggle = false;
        MageNuggetsClassic.minimapToggle = false;
        MageNuggetsClassic.moonkinTog = true;
        MageNugMoonkin_Frame:Hide()
        MNmoonFire_Frame:Hide();
        MNinsectSwarm_Frame:Hide();
        MNstarSurge_Frame:Hide();
    end
    if(mnenglishClass == 'DRUID') then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff "..magenugVer.." loaded! Some Options Disabled (Class:"..UnitClass("Player")..")")
        MageNuggetsClassic.igniteTog = false;
        MageNuggetsClassic.ssMonitorToggle = false;
        MageNuggetsClassic.mirrorImageToggle = false;
        MageNuggetsClassic.minimapToggle = false;
        if(MageNuggetsClassic.moonkinCombat == true) then
            MageNugMoonkin_Frame:Hide();
            MNmoonFire_Frame:Hide();
            MNinsectSwarm_Frame:Hide();
            MNstarSurge_Frame:Hide();
        else
            if (MageNuggetsClassic.moonkinTog == false) or (MageNuggetsClassic.moonkinTog == nil) then
                MageNugMoonkin_Frame:Show();
                MNmoonFire_Frame:Show();
                MNinsectSwarm_Frame:Show();
                MNstarSurge_Frame:Show();
            end
        end
        if (MageNuggetsClassic.moonkinMin == true) then
            MageNugMoonkin_Frame_Texture:Hide();
        end
    end
    if(mnenglishClass == 'MAGE') then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff "..magenugVer.." loaded! (Use: /MageNuggetsClassic options)")
        MageNuggetsClassic.moonkinTog = true;
        MageNugMoonkin_Frame:Hide();
        MNmoonFire_Frame:Hide();
        MNinsectSwarm_Frame:Hide();
        MNstarSurge_Frame:Hide();
        MNSpellSteal_FrameTitleText:SetText("|cff33ccffS P E L L S T E A L");
        MNSpellStealFocus_FrameTitleText:SetText("|cff33ccffFOCUS SPELLSTEAL");
    end

    MageNugMoonkinToggle_FrameText:SetText("|cff00BFFF".."Mage".."|cff00FF00".." Nuggets")
    MageNugCauterizeFrame:Hide();
    if(MageNuggetsClassic.abCastTimeToggle == true) then
        MNabCast_Frame:Show();
    else
        MNabCast_Frame:Hide();
    end

end

----------------------------------------------------------------------------------------
--                              SAVE FRAMES                                           --
----------------------------------------------------------------------------------------
MageNuggetsClassic_Frames = {
    ignite_point = "CENTER";
    ignite_relativePoint = "CENTER";
    ignite_xOfs = 0;
    ignite_yOfs = 0;
    frostbomb_point = "CENTER";
    frostbomb_relativePoint = "CENTER";
    frostbomb_xOfs = 0;
    frostbomb_yOfs = 0;
    hs_point = "CENTER";
    hs_relativePoint = "CENTER";
    hs_xOfs = 0;
    hs_yOfs = 0;
    pyroclasm_point = "CENTER";
    pyroclasm_relativePoint = "CENTER";
    pyroclasm_xOfs = 0;
    pyroclasm_yOfs = 0;
    hu_point = "CENTER";
    hu_relativePoint = "CENTER";
    hu_xOfs = 0;
    hu_yOfs = 0;
    caut_point = "CENTER";
    caut_relativePoint = "CENTER";
    caut_xOfs = 0;
    caut_yOfs = 0;
    ab_point = "CENTER";
    ab_relativePoint = "CENTER";
    ab_xOfs = 0;
    ab_yOfs = 0;
    poly_point = "CENTER";
    poly_relativePoint = "CENTER";
    poly_xOfs = 0;
    poly_yOfs = 0;
    mb_point = "CENTER";
    mb_relativePoint = "CENTER";
    mb_xOfs = 0;
    mb_yOfs = 0;
    fof_point = "CENTER";
    fof_relativePoint = "CENTER";
    fof_xOfs = 0;
    fof_yOfs = 0;
    bf_point = "CENTER";
    bf_relativePoint = "CENTER";
    bf_xOfs = 0;
    bf_yOfs = 0;
    spellsteal_point = "CENTER";
    spellsteal_relativePoint = "CENTER";
    spellsteal_xOfs = 0;
    spellsteal_yOfs = 0;
    spellstealfocus_point = "CENTER";
    spellstealfocus_relativePoint = "CENTER";
    spellstealfocus_xOfs = 0;
    spellstealfocus_yOfs = 0;
    mi_point = "CENTER";
    mi_relativePoint = "CENTER";
    mi_xOfs = 0;
    mi_yOfs = 0;
    cautTimer_point = "CENTER";
    cautTimer_relativePoint = "CENTER";
    cautTimer_xOfs = 0;
    cautTimer_yOfs = 0;
}

function MageNugz_SaveFrame_Position()
    MageNuggetsClassic_Frames.ignite_point, _, MageNuggetsClassic_Frames.ignite_relativePoint, MageNuggetsClassic_Frames.ignite_xOfs, MageNuggetsClassic_Frames.ignite_yOfs = MageNugIgnite_Frame:GetPoint();
    MageNuggetsClassic_Frames.hs_point, _, MageNuggetsClassic_Frames.hs_relativePoint, MageNuggetsClassic_Frames.hs_xOfs, MageNuggetsClassic_Frames.hs_yOfs = MageNugProcFrame:GetPoint();
    MageNuggetsClassic_Frames.hu_point, _, MageNuggetsClassic_Frames.hu_relativePoint, MageNuggetsClassic_Frames.hu_xOfs, MageNuggetsClassic_Frames.hu_yOfs = MageNugProcHUFrame:GetPoint();
    MageNuggetsClassic_Frames.caut_point, _, MageNuggetsClassic_Frames.caut_relativePoint, MageNuggetsClassic_Frames.caut_xOfs, MageNuggetsClassic_Frames.caut_yOfs = MageNugCauterizeFrame:GetPoint();
    MageNuggetsClassic_Frames.ab_point, _, MageNuggetsClassic_Frames.ab_relativePoint, MageNuggetsClassic_Frames.ab_xOfs, MageNuggetsClassic_Frames.ab_yOfs = MageNugAB_Frame:GetPoint();
    MageNuggetsClassic_Frames.poly_point, _, MageNuggetsClassic_Frames.poly_relativePoint, MageNuggetsClassic_Frames.poly_xOfs, MageNuggetsClassic_Frames.poly_yOfs = MageNugPolyFrame:GetPoint();
    MageNuggetsClassic_Frames.mb_point, _, MageNuggetsClassic_Frames.mb_relativePoint, MageNuggetsClassic_Frames.mb_xOfs, MageNuggetsClassic_Frames.mb_yOfs = MageNugMBProcFrame:GetPoint();
    MageNuggetsClassic_Frames.fof_point, _, MageNuggetsClassic_Frames.fof_relativePoint, MageNuggetsClassic_Frames.fof_xOfs, MageNuggetsClassic_Frames.fof_yOfs = MageNugFoFProcFrame:GetPoint();
    MageNuggetsClassic_Frames.bf_point, _, MageNuggetsClassic_Frames.bf_relativePoint, MageNuggetsClassic_Frames.bf_xOfs, MageNuggetsClassic_Frames.bf_yOfs = MageNugBFProcFrame:GetPoint();
    MageNuggetsClassic_Frames.spellsteal_point, _, MageNuggetsClassic_Frames.spellsteal_relativePoint, MageNuggetsClassic_Frames.spellsteal_xOfs, MageNuggetsClassic_Frames.spellsteal_yOfs = MNSpellSteal_Frame:GetPoint();
    MageNuggetsClassic_Frames.spellstealfocus_point, _, MageNuggetsClassic_Frames.spellstealfocus_relativePoint, MageNuggetsClassic_Frames.spellstealfocus_xOfs, MageNuggetsClassic_Frames.spellstealfocus_yOfs = MNSpellStealFocus_Frame:GetPoint();
    MageNuggetsClassic_Frames.mi_point, _, MageNuggetsClassic_Frames.mi_relativePoint, MageNuggetsClassic_Frames.mi_xOfs, MageNuggetsClassic_Frames.mi_yOfs = MageNugMI_Frame:GetPoint();
    MageNuggetsClassic_Frames.cautTimer_point, _, MageNuggetsClassic_Frames.cautTimer_relativePoint, MageNuggetsClassic_Frames.cautTimer_xOfs, MageNuggetsClassic_Frames.cautTimer_yOfs = MageNugCauterize_Frame:GetPoint();
end


function MageNugz_SetFrame_Positions()
    loadMageNuggetOptionsVariables_OnLoadEvent();
    MageNugIgnite_Frame:ClearAllPoints();
    MageNugIgnite_Frame:SetPoint(MageNuggetsClassic_Frames.ignite_point, "UIParent", MageNuggetsClassic_Frames.ignite_relativePoint, MageNuggetsClassic_Frames.ignite_xOfs, MageNuggetsClassic_Frames.ignite_yOfs);
    MageNugProcFrame:ClearAllPoints();
    MageNugProcFrame:SetPoint(MageNuggetsClassic_Frames.hs_point, "UIParent", MageNuggetsClassic_Frames.hs_relativePoint, MageNuggetsClassic_Frames.hs_xOfs, MageNuggetsClassic_Frames.hs_yOfs);
    MageNugPyroclasmProcFrame:ClearAllPoints();
    MageNugPyroclasmProcFrame:SetPoint(MageNuggetsClassic_Frames.pyroclasm_point, "UIParent", MageNuggetsClassic_Frames.pyroclasm_relativePoint, MageNuggetsClassic_Frames.pyroclasm_xOfs, MageNuggetsClassic_Frames.pyroclasm_yOfs);
    MageNugProcHUFrame:ClearAllPoints();
    MageNugProcHUFrame:SetPoint(MageNuggetsClassic_Frames.hu_point, "UIParent", MageNuggetsClassic_Frames.hu_relativePoint, MageNuggetsClassic_Frames.hu_xOfs, MageNuggetsClassic_Frames.hu_yOfs);
    MageNugCauterizeFrame:ClearAllPoints();
    MageNugCauterizeFrame:SetPoint(MageNuggetsClassic_Frames.caut_point, "UIParent", MageNuggetsClassic_Frames.caut_relativePoint, MageNuggetsClassic_Frames.caut_xOfs, MageNuggetsClassic_Frames.caut_yOfs);
    MageNugAB_Frame:ClearAllPoints();
    MageNugAB_Frame:SetPoint(MageNuggetsClassic_Frames.ab_point, "UIParent", MageNuggetsClassic_Frames.ab_relativePoint, MageNuggetsClassic_Frames.ab_xOfs, MageNuggetsClassic_Frames.ab_yOfs);
    MageNugPolyFrame:ClearAllPoints();
    MageNugPolyFrame:SetPoint(MageNuggetsClassic_Frames.poly_point, "UIParent", MageNuggetsClassic_Frames.poly_relativePoint, MageNuggetsClassic_Frames.poly_xOfs, MageNuggetsClassic_Frames.poly_yOfs);
    MageNugMBProcFrame:ClearAllPoints();
    MageNugMBProcFrame:SetPoint(MageNuggetsClassic_Frames.mb_point, "UIParent", MageNuggetsClassic_Frames.mb_relativePoint, MageNuggetsClassic_Frames.mb_xOfs, MageNuggetsClassic_Frames.mb_yOfs);
    MageNugFoFProcFrame:ClearAllPoints();
    MageNugFoFProcFrame:SetPoint(MageNuggetsClassic_Frames.fof_point, "UIParent", MageNuggetsClassic_Frames.fof_relativePoint, MageNuggetsClassic_Frames.fof_xOfs, MageNuggetsClassic_Frames.fof_yOfs);
    MageNugBFProcFrame:ClearAllPoints();
    MageNugBFProcFrame:SetPoint(MageNuggetsClassic_Frames.bf_point, "UIParent", MageNuggetsClassic_Frames.bf_relativePoint, MageNuggetsClassic_Frames.bf_xOfs, MageNuggetsClassic_Frames.bf_yOfs);
    MNSpellSteal_Frame:ClearAllPoints();
    MNSpellSteal_Frame:SetPoint(MageNuggetsClassic_Frames.spellsteal_point, "UIParent", MageNuggetsClassic_Frames.spellsteal_relativePoint, MageNuggetsClassic_Frames.spellsteal_xOfs, MageNuggetsClassic_Frames.spellsteal_yOfs);
    MNSpellStealFocus_Frame:ClearAllPoints();
    MNSpellStealFocus_Frame:SetPoint(MageNuggetsClassic_Frames.spellstealfocus_point, "UIParent", MageNuggetsClassic_Frames.spellstealfocus_relativePoint, MageNuggetsClassic_Frames.spellstealfocus_xOfs, MageNuggetsClassic_Frames.spellstealfocus_yOfs);
    MNSpellSteal_Frame:ClearAllPoints();
    MNSpellSteal_Frame:SetPoint(MageNuggetsClassic_Frames.spellsteal_point, "UIParent", MageNuggetsClassic_Frames.spellsteal_relativePoint, MageNuggetsClassic_Frames.spellsteal_xOfs, MageNuggetsClassic_Frames.spellsteal_yOfs);
    MageNugMI_Frame:ClearAllPoints();
    MageNugMI_Frame:SetPoint(MageNuggetsClassic_Frames.mi_point, "UIParent", MageNuggetsClassic_Frames.mi_relativePoint, MageNuggetsClassic_Frames.mi_xOfs, MageNuggetsClassic_Frames.mi_yOfs);
    MageNugCauterize_Frame:ClearAllPoints();
    MageNugCauterize_Frame:SetPoint(MageNuggetsClassic_Frames.cautTimer_point, "UIParent", MageNuggetsClassic_Frames.cautTimer_relativePoint, MageNuggetsClassic_Frames.cautTimer_xOfs, MageNuggetsClassic_Frames.cautTimer_yOfs);
end

function CombatText_OnEnter()
  GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
  GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."Checking this will disable all notifications sent to".." \n".."the chat console. This includes polymorph, evocation,".." \n".."spellsteal notifications and all other chat console notifications.")
  GameTooltip:Show()
end

function MNLockFrames(self)
    if (MageNuggetsClassic.lockFrames == false)then
       self:StartMoving(); self.isMoving = true;
    end
end

function MageNugz_MinimapButton_Move()
	MageNug_MinimapFrame:SetPoint("TOPLEFT","Minimap","TOPLEFT",82-(100*cos(MageNuggetsClassic.MinimapPos)),(100*sin(MageNuggetsClassic.MinimapPos))-82)
end

function MageNugz_MinimapButton_Move_SexyMaps()
	MageNug_MinimapFrame:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(MageNuggetsClassic.MinimapPos)),(80*sin(MageNuggetsClassic.MinimapPos))-52)
end

function MageNugz_MinimapButton_DraggingFrame_OnUpdate()
	local xpos,ypos = GetCursorPosition()

  -- Check to see if sexy map is in use and use custom drag
  if (SexyMapCustomBackdrop ~= nil) then
    local xminSexyMaps,yminSexyMaps = SexyMapCustomBackdrop:GetLeft(), SexyMapCustomBackdrop:GetBottom()
    xpos = xminSexyMaps-xpos/UIParent:GetScale()+50
    ypos = ypos/UIParent:GetScale()-yminSexyMaps-50
    MageNuggetsClassic.MinimapPos = math.deg(math.atan2(ypos,xpos))
    MageNugz_MinimapButton_Move_SexyMaps()
  else
    local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()
    xpos = xmin-xpos/UIParent:GetScale()+70
    ypos = ypos/UIParent:GetScale()-ymin-70
    MageNuggetsClassic.MinimapPos = math.deg(math.atan2(ypos,xpos))
    MageNugz_MinimapButton_Move()
  end
end

function MageNugz_Minimap_OnClick()
    local englishFaction, localizedFaction = UnitFactionGroup("player")
    if (englishFaction == "Horde")then
        MageNugHordeFrame:Show();
    elseif (englishFaction == "Alliance") then
        MageNugAlliFrame:Show();
    end
end

function MNRecallFrames()
        MNSpellStealFocus_Frame:SetClampedToScreen(true);
        MageNugIgnite_Frame:SetClampedToScreen(true);
        MageNugCauterize_Frame:SetClampedToScreen(true);
        MageNugAB_Frame:SetClampedToScreen(true);
        MNabCast_Frame:SetClampedToScreen(true);
        MageNugProcFrame:SetClampedToScreen(true);
        MageNugPyroclasmProcFrame:SetClampedToScreen(true);
        MageNugPolyFrame:SetClampedToScreen(true);
        MageNugBFProcFrame:SetClampedToScreen(true);
        MageNugMBProcFrame:SetClampedToScreen(true);
        MageNugFoFProcFrame:SetClampedToScreen(true);
        MNSpellSteal_Frame:SetClampedToScreen(true);
        MageNugMI_Frame:SetClampedToScreen(true);
        MageNugMoonkin_Frame:SetClampedToScreen(true);
        MNmoonFire_Frame:SetClampedToScreen(true);
        MNinsectSwarm_Frame:SetClampedToScreen(true);
        MNstarSurge_Frame:SetClampedToScreen(true);
end


function  MageNugCauterizeSize() -- Cauterize Slider
    local tempInt = MageNugOptionsFrame_Slider5:GetValue()

    if not MageNugOptionsFrame_Slider5._onsetting then
        MageNugOptionsFrame_Slider5._onsetting = true
        MageNugOptionsFrame_Slider5:SetValue(MageNugOptionsFrame_Slider5:GetValue())
        tempInt = MageNugOptionsFrame_Slider5:GetValue()
        MageNugOptionsFrame_Slider5._onsetting = false
    else return end

    if (tempInt == 0) then
        MageNugCauterizeFrame:SetScale(0.7);
        MageNuggetsClassic.cautSize = 0;
    elseif (tempInt == 1) then
        MageNugCauterizeFrame:SetScale(0.8);
        MageNuggetsClassic.cautSize = 1;
    elseif (tempInt == 2) then
        MageNugCauterizeFrame:SetScale(0.9);
        MageNuggetsClassic.cautSize = 2;
    elseif (tempInt == 3) then
        MageNugCauterizeFrame:SetScale(1.0);
        MageNuggetsClassic.cautSize = 3;
    elseif (tempInt == 4) then
        MageNugCauterizeFrame:SetScale(1.2);
        MageNuggetsClassic.cautSize = 4;
    elseif (tempInt == 5) then
        MageNugCauterizeFrame:SetScale(1.4);
        MageNuggetsClassic.cautSize = 5;
    elseif (tempInt == 6) then
        MageNugCauterizeFrame:SetScale(1.6);
        MageNuggetsClassic.cautSize = 6;
    end
end



function  MageNugSSMonitorSize() -- SS Slider
    local tempInt = MageNugOptionsFrame_Slider2:GetValue()

    if not MageNugOptionsFrame_Slider2._onsetting then
        MageNugOptionsFrame_Slider2._onsetting = true
        MageNugOptionsFrame_Slider2:SetValue(MageNugOptionsFrame_Slider2:GetValue())
        tempInt = MageNugOptionsFrame_Slider2:GetValue()
        MageNugOptionsFrame_Slider2._onsetting = false
    else return end

    if (tempInt == 0) then
        MNSpellSteal_Frame:SetScale(0.7);
        MageNuggetsClassic.ssMonitorSize = 0;
    elseif (tempInt == 1) then
        MNSpellSteal_Frame:SetScale(0.8);
        MageNuggetsClassic.ssMonitorSize = 1;
    elseif (tempInt == 2) then
        MNSpellSteal_Frame:SetScale(0.9);
        MageNuggetsClassic.ssMonitorSize = 2;
    elseif (tempInt == 3) then
        MNSpellSteal_Frame:SetScale(1.0);
        MageNuggetsClassic.ssMonitorSize = 3;
    elseif (tempInt == 4) then
        MNSpellSteal_Frame:SetScale(1.1);
        MageNuggetsClassic.ssMonitorSize = 4;
    elseif (tempInt == 5) then
        MNSpellSteal_Frame:SetScale(1.2);
        MageNuggetsClassic.ssMonitorSize = 5;
    elseif (tempInt == 6) then
        MNSpellSteal_Frame:SetScale(1.3);
        MageNuggetsClassic.ssMonitorSize = 6;
    end
end

function  MageNugProcMonitorSize() --Proc Slider
    local tempInt = MageNugOptionsFrame_Slider4:GetValue()

    if not MageNugOptionsFrame_Slider4._onsetting then
        MageNugOptionsFrame_Slider4._onsetting = true
        MageNugOptionsFrame_Slider4:SetValue(MageNugOptionsFrame_Slider4:GetValue())
        tempInt = MageNugOptionsFrame_Slider4:GetValue()
        MageNugOptionsFrame_Slider4._onsetting = false
    else return end

    if (tempInt == 0) then
        MageNugProcFrame:SetScale(0.7);
        MageNugPyroclasmProcFrame:SetScale(0.7);
        MageNugMBProcFrame:SetScale(0.7);
        MageNugFoFProcFrame:SetScale(0.7);
        MageNugBFProcFrame:SetScale(0.7);
        MageNuggetsClassic.procMonitorSize = 0;
    elseif (tempInt == 1) then
        MageNugProcFrame:SetScale(0.8);
        MageNugPyroclasmProcFrame:SetScale(0.8);
        MageNugMBProcFrame:SetScale(0.8);
        MageNugFoFProcFrame:SetScale(0.8);
        MageNugBFProcFrame:SetScale(0.8);
        MageNuggetsClassic.procMonitorSize = 1;
    elseif (tempInt == 2) then
        MageNugProcFrame:SetScale(0.9);
        MageNugPyroclasmProcFrame:SetScale(0.9);
        MageNugMBProcFrame:SetScale(0.9);
        MageNugFoFProcFrame:SetScale(0.9);
        MageNugBFProcFrame:SetScale(0.9);
        MageNuggetsClassic.procMonitorSize = 2;
    elseif (tempInt == 3) then
        MageNugProcFrame:SetScale(1.0);
        MageNugPyroclasmProcFrame:SetScale(1.0);
        MageNugMBProcFrame:SetScale(1.0);
        MageNugFoFProcFrame:SetScale(1.0);
        MageNugBFProcFrame:SetScale(1.0);
        MageNuggetsClassic.procMonitorSize = 3;
    elseif (tempInt == 4) then
        MageNugProcFrame:SetScale(1.1);
        MageNugPyroclasmProcFrame:SetScale(1.1);
        MageNugMBProcFrame:SetScale(1.1);
        MageNugFoFProcFrame:SetScale(1.1);
        MageNugBFProcFrame:SetScale(1.1);
        MageNuggetsClassic.procMonitorSize = 4;
    elseif (tempInt == 5) then
        MageNugProcFrame:SetScale(1.2);
        MageNugPyroclasmProcFrame:SetScale(1.2);
        MageNugMBProcFrame:SetScale(1.2);
        MageNugFoFProcFrame:SetScale(1.2);
        MageNugBFProcFrame:SetScale(1.2);
        MageNuggetsClassic.procMonitorSize = 5;
    elseif (tempInt == 6) then
        MageNugProcFrame:SetScale(1.3);
        MageNugPyroclasmProcFrame:SetScale(1.3);
        MageNugMBProcFrame:SetScale(1.3);
        MageNugFoFProcFrame:SetScale(1.3);
        MageNugBFProcFrame:SetScale(1.3);
        MageNuggetsClassic.procMonitorSize = 6;
    end
end

function MageNugPolyFrameSize()
    local tempInt = MageNugOptionsFrame_Slider1:GetValue()

    if not MageNugOptionsFrame_Slider1._onsetting then
        MageNugOptionsFrame_Slider1._onsetting = true
        MageNugOptionsFrame_Slider1:SetValue(MageNugOptionsFrame_Slider1:GetValue())
        tempInt = MageNugOptionsFrame_Slider1:GetValue()
        MageNugOptionsFrame_Slider1._onsetting = false
    else return end

    if (tempInt == 0) then
        MageNugPolyFrame:SetScale(0.7);
        MageNuggetsClassic.polyFrameSize = 0;
    elseif (tempInt == 1) then
        MageNugPolyFrame:SetScale(0.8);
        MageNuggetsClassic.polyFrameSize = 1;
    elseif (tempInt == 2) then
        MageNugPolyFrame:SetScale(0.9);
        MageNuggetsClassic.polyFrameSize = 2;
    elseif (tempInt == 3) then
        MageNugPolyFrame:SetScale(1.0);
        MageNuggetsClassic.polyFrameSize = 3;
    elseif (tempInt == 4) then
        MageNugPolyFrame:SetScale(1.2);
        MageNuggetsClassic.polyFrameSize = 4;
    elseif (tempInt == 5) then
        MageNugPolyFrame:SetScale(1.4);
        MageNuggetsClassic.polyFrameSize = 5;
    elseif (tempInt == 6) then
        MageNugPolyFrame:SetScale(1.6);
        MageNuggetsClassic.polyFrameSize = 6;
    end
end



function Tab2_OnEnter()
  GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
  GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF".."Messages are picked at random.")
  GameTooltip:Show()
end

function Monitors_OnEnter()
  if (MageNuggetsClassic.toolTips == true) then
    GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
    GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."You can disable or resize this".." \n".."monitor in options.")
    GameTooltip:Show()
    end
end

function SPMonitor_OnEnter()
    if (MageNuggetsClassic.toolTips == true) then
        GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
        GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."You can customize or disable this".." \n".."monitor in options.")
        GameTooltip:Show()
    end
end

function MNcooldownOnEnter()
     if (MageNuggetsClassic.toolTips == true) then
        GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
        GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."See Mage Nuggets Classic Options -> Cooldowns")
        GameTooltip:Show()
    end
end

-------------------------------------------------------------------------------
---------------------------------Fire Nuggets----------------------------------
-------------------------------------------------------------------------------

function MNFireNuggetSimpleUiToggle()
  local isChecked = MageNugFireNugOptionFrame_SimpleUiCheckButton:GetChecked();
  if (isChecked == true) then
    MageNugIgnite_FrameTexture:SetTexture('')
    MageNugIgnite_FrameTexture2:SetTexture('')
    MageNugIgnite_FrameTexture3:SetTexture('')
    MageNugIgnite_FrameCombustionTexture:SetPoint("CENTER",-37,0);
    MageNugIgnite_FrameCombustionTexture:SetSize(35,35);
    MageNugIgnite_FramePhenonixFlamesTexture:SetPoint("CENTER",37,0);
    MageNugIgnite_FramePhenonixFlamesTexture:SetSize(35,35);
    MageNuggetsClassic.fireNugSimpleUiToggle = true;
  else
    MageNugIgnite_FrameCombustionTexture:SetPoint("CENTER",-40,0);
    MageNugIgnite_FrameCombustionTexture:SetSize(28,28);
    MageNugIgnite_FramePhenonixFlamesTexture:SetPoint("CENTER",40,0);
    MageNugIgnite_FramePhenonixFlamesTexture:SetSize(28,28);
    MageNuggetsClassic.fireNugSimpleUiToggle = false;
  end
end

function MNigniteToggle()
    local isChecked = MageNugFireNugOptionFrame_IgniteCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggetsClassic.igniteTog = true;
    else
        MageNuggetsClassic.igniteTog = false;
    end
end

function MNFireNuggetNotifyBorderToggle()
    local isChecked = MageNugFireNugOptionFrame_NotifyCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggetsClassic.FireNuggetNotifyBorderToggle = true;
    else
        MageNuggetsClassic.FireNuggetNotifyBorderToggle = false;
    end
end


function MageNugFireNugSize()
    local tempInt = MageNugFireNugOptionFrame_SizeSlider:GetValue()
    if not MageNugFireNugOptionFrame_SizeSlider._onsetting then
        MageNugFireNugOptionFrame_SizeSlider._onsetting = true
        MageNugFireNugOptionFrame_SizeSlider:SetValue(MageNugFireNugOptionFrame_SizeSlider:GetValue())
        tempInt = MageNugFireNugOptionFrame_SizeSlider:GetValue()
        MageNugFireNugOptionFrame_SizeSlider._onsetting = false
    else return end

    if (tempInt == 0) then
        MageNugIgnite_Frame:SetScale(0.7);
        MageNuggetsClassic.fireNuggetSize = 0;
    elseif (tempInt == 1) then
        MageNugIgnite_Frame:SetScale(0.8);
        MageNuggetsClassic.fireNuggetSize = 1;
    elseif (tempInt == 2) then
        MageNugIgnite_Frame:SetScale(0.9);
        MageNuggetsClassic.fireNuggetSize = 2;
    elseif (tempInt == 3) then
        MageNugIgnite_Frame:SetScale(1.0);
        MageNuggetsClassic.fireNuggetSize = 3;
    elseif (tempInt == 4) then
        MageNugIgnite_Frame:SetScale(1.1);
        MageNuggetsClassic.fireNuggetSize = 4;
    elseif (tempInt == 5) then
        MageNugIgnite_Frame:SetScale(1.2);
        MageNuggetsClassic.fireNuggetSize = 5;
    elseif (tempInt == 6) then
        MageNugIgnite_Frame:SetScale(1.3);
        MageNuggetsClassic.fireNuggetSize = 6;
    elseif (tempInt == 7) then
        MageNugIgnite_Frame:SetScale(1.5);
        MageNuggetsClassic.fireNuggetSize = 7;
    elseif (tempInt == 8) then
        MageNugIgnite_Frame:SetScale(1.7);
        MageNuggetsClassic.fireNuggetSize = 8;
    elseif (tempInt == 9) then
        MageNugIgnite_Frame:SetScale(1.9);
        MageNuggetsClassic.fireNuggetSize = 9;
    elseif (tempInt == 10) then
        MageNugIgnite_Frame:SetScale(2.1);
        MageNuggetsClassic.fireNuggetSize = 10;
    elseif (tempInt == 11) then
        MageNugIgnite_Frame:SetScale(2.5);
        MageNuggetsClassic.fireNuggetSize = 10;
    end
end

function MageNugFireNugBorder()
    local tempInt = MageNugFireNugOptionFrame_BorderSlider:GetValue()

    if not MageNugFireNugOptionFrame_BorderSlider._onsetting then
        MageNugFireNugOptionFrame_BorderSlider._onsetting = true
        MageNugFireNugOptionFrame_BorderSlider:SetValue(MageNugFireNugOptionFrame_BorderSlider:GetValue())
        tempInt = MageNugFireNugOptionFrame_BorderSlider:GetValue()
        MageNugFireNugOptionFrame_BorderSlider._onsetting = false
    else return end

    if (tempInt == 0) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\Generic1Player_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\Generic1Player_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\Generic1Player_Circular_Frame")
      MageNuggetsClassic.fireNuggetBorder = 0;
    elseif (tempInt == 1) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\Atramedes_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\Atramedes_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\Atramedes_Circular_Frame")
      MageNuggetsClassic.fireNuggetBorder = 1;
    elseif (tempInt == 2) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\Horde_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\Horde_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\Horde_Circular_Frame")
      MageNuggetsClassic.fireNuggetBorder = 2;
    elseif (tempInt == 3) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\Alliance_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\Alliance_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\Alliance_Circular_Frame")
      MageNuggetsClassic.fireNuggetBorder = 3;
    elseif (tempInt == 4) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\Mechanical_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\Mechanical_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\Mechanical_Circular_Frame")
      MageNuggetsClassic.fireNuggetBorder = 4;
    elseif (tempInt == 5) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\MetalBronze_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\MetalBronze_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\MetalBronze_Circular_Frame")
      MageNuggetsClassic.fireNuggetBorder = 5;
    elseif (tempInt == 6) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\MetalEternium_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\MetalEternium_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\MetalEternium_Circular_Frame")
      MageNuggetsClassic.fireNuggetBorder = 6;
    elseif (tempInt == 7) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\StoneTan_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\StoneTan_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\StoneTan_Circular_Frame")
      MageNuggetsClassic.fireNuggetBorder = 7;
    elseif (tempInt == 8) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\WoodBoards_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\WoodBoards_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\WoodBoards_Circular_Frame")
      MageNuggetsClassic.fireNuggetBorder = 8;
    elseif (tempInt == 9) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\WowUI_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\WowUI_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\WowUI_Circular_Frame")
      MageNuggetsClassic.fireNuggetBorder = 9;
    elseif (tempInt == 10) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\Meat_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\Meat_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\Meat_Circular_Frame")
      MageNuggetsClassic.fireNuggetBorder = 10;
    elseif (tempInt == 11) then
      MageNugIgnite_FrameTexture:SetTexture("")
      MageNugIgnite_FrameTexture2:SetTexture("")
      MageNugIgnite_FrameTexture3:SetTexture("")
      MageNuggetsClassic.fireNuggetBorder = 11;
    end
end

function MNFireBuggetBorderSliderTooltip()
  if(MageNuggetsClassic.fireNugSimpleUiToggle == true) then
    GameTooltip:SetOwner(MageNugFireNugOptionFrame_BorderSlider)
    GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."Please disable Simple UI to change the border.")
    GameTooltip:Show()
  end
end
