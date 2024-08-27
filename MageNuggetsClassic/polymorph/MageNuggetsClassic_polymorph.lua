local polyTimer = 0;

function MageNuggetsClassicPoly_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 1.0) then
        if (polyTimer >= 0) then
            polyTimer = RoundZero(polyTimer - 1.0);
            MageNugPolyFrameTimerText:SetText(polyTimer);
            MageNugPolyFrame_Bar:SetValue(polyTimer);
            if(polyTimer <= 0) then
                MageNugPolyFrame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end
end

function MageNuggetsClassicPolymorphAuraApplied(arg, destName)
    local polyName = nil;

    if (arg == 9484) then
        polyName = "Shackle";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_slow");
    elseif (arg == 2637) then
        polyName = "Hibernate";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_sleep");
    elseif (arg == 76780) then
        polyName = "Bind";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_shaman_bindelemental");
    elseif (arg == 115078) then
        polyName = "Paralysis";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\ability_monk_paralysis");
    elseif (arg == 51514) then
        polyName = "HEX";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_shaman_hex");
    elseif (arg == 28272) then
        polyName = "Polymorph";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphpig");
    elseif (arg == 61305) then
        polyName = "Polymorph";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Achievement_halloween_cat_01");
    elseif (arg == 61721) then
        polyName = "Polymorph";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphrabbit");
    elseif (arg == 28271) then
        polyName = "Polymorph";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Ability_hunter_pet_turtle");
    elseif (arg == 126819) then
        polyName = "Polymorph";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\inv_pet_porcupine");
    elseif (arg == 161354) then
        polyName = "Polymorph";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\ability_hunter_aspectofthemonkey");
    elseif (arg == 118) then
        polyName = "Polymorph";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_nature_polymorph");
    end

    if (polyName ~= nil) then
        _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", arg, "PLAYER|HARMFUL");
        if (polyExpTime ~= nil) then
            polyTimer = RoundZero(polyExpTime - GetTime());
        else
            polyTimer = 50;
        end

        MageNugPolyFrameText:SetText("|cffFFFFFF"..polyName..":\n|cffFFFFFF "..destName);
        MageNugPolyFrameTimerText:SetText(polyTimer);
        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
        MageNugPolyFrame_Bar:SetValue(polyTimer);
        MageNugPolyFrame:Show();
    end
end

function MageNuggetsClassicPolymorphAuraRemoved(arg, destName)
    local combatText = nil;
    local polyName = nil;

    if (arg == 9484) then
        combatText = "Shackle Broken";
        polyName = "Shackle Broken On";
    elseif (arg == 115078) then
        combatText = "Paralysis Broken";
        polyName = "Paralysis Broken On";
    elseif (arg == 2637) then
        combatText = "Hibernate Broken";
        polyName = "Hibernate Broken On";
    elseif (arg == 76780) then
        combatText = "Bind Broken";
        polyName = "Bind Broken On";
    elseif (arg == 51514) then
        combatText = "Hex Broken";
        polyName = "Hex Broken On";
    elseif (arg == 28272) then
        combatText = "Polymorph Broken";
        polyName = "Polymorph(Pig) Broken On";
    elseif (arg == 118) then
        combatText = "Polymorph Broken";
        polyName = "Polymorph(Sheep) Broken On";
    elseif (arg == 28271) then
        combatText = "Polymorph Broken";
        polyName = "Polymorph(Turtle) Broken On";
    elseif (arg == 61721) then
        combatText = "Polymorph Broken";
        polyName = "Polymorph(Rabbit) Broken On";
    elseif (arg == 61305) then
        combatText = "Polymorph Broken";
        polyName = "Polymorph(Black Cat) Broken On";
    elseif (arg == 126819) then
        combatText = "Polymorph Broken";
        polyName = "Polymorph(Porcupine) Broken On";
    elseif (arg == 161354) then
        combatText = "Polymorph Broken";
        polyName = "Polymorph(Monkey) Broken On";
    end

    if (polyName ~= nil) then
      MageNugPolyFrame:Hide();
      polyTimer = 0;
      mnCombatTextSize = 0;
      MageNugCombatText_Frame_Text:SetTextColor(1,0.2,1,1);
      MageNugCombatText_Frame_Text:SetText(combatText);

      if (MageNuggetsClassic.consoleTextEnabled == true) then
          DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000"..polyName..":|cffFFFFFF "..destName);
      end
      if (MageNuggetsClassic.polySoundToggle == true) then
          PlaySoundFile("Interface\\AddOns\\MageNuggetsClassic\\Sounds\\"..MageNuggetsClassic.polySound2)
      end
    end
end

function MageNuggetsClassicPolymorphAuraRefresh(arg, destName)
    local polyName = nil;

    if (arg == 115078) then
        polyName = "Paralysis";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\ability_monk_paralysis");
    elseif (arg == 9484) then
        polyName = "Shackle";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_slow");
    elseif (arg == 2637) then
        polyName = "Hibernate";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_sleep");
    elseif (arg == 51514) then
        polyName = "Hex";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_shaman_hex");
    elseif (arg == 28272) then
        polyName = "Polymorph";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphpig");
    elseif (arg == 61305) then
        polyName = "Polymorph";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Achievement_halloween_cat_01");
    elseif (arg == 61721) then
        polyName = "Polymorph";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphrabbit");
    elseif (arg == 28271) then
        polyName = "Polymorph";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Ability_hunter_pet_turtle");
    elseif (arg == 126819) then
        polyName = "Polymorph";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\inv_pet_porcupine");
    elseif (arg == 161354) then
        polyName = "Polymorph";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\ability_hunter_aspectofthemonkey");
    elseif (arg == 118)  then
        polyName = "Polymorph";
        MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_nature_polymorph");
    end

    if (polyName ~= nil) then
        _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", arg, "PLAYER|HARMFUL");
        if(polyExpTime ~= nil) then
            polyTimer = RoundZero(polyExpTime - GetTime());
        else
            polyTimer = 50;
        end

        MageNugPolyFrameText:SetText("|cffFFFFFF"..polyName..":\n|cffFFFFFF "..destName);
        MageNugPolyFrameTimerText:SetText(polyTimer);
        MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
        MageNugPolyFrame_Bar:SetValue(polyTimer);
        MageNugPolyFrame:Show();
    end
end
