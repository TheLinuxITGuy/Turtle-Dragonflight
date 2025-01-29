local lOriginal_TargetDebuffButton_Update = nil;
local TARGETFRAMEBUFF_MAX_TARGET_DEBUFFS = 16;
local TARGETFRAMEBUFF_MAX_TARGET_BUFFS = 16;


-- hook original update-function
function TargetFrameBuff_OnLoad()
	lOriginal_TargetDebuffButton_Update	= TargetDebuffButton_Update;
	TargetDebuffButton_Update = TargetFrameBuff_Update;
	
	lOriginal_TargetDebuffButton_Update()
	TargetFrameBuff_Restore();
end


-- use extended update-function (original code from FrameXML/TargetFrame.lua)
function TargetFrameBuff_Update()
	
	local num_buff = 0;
	local num_debuff = 0;
	local button, buff;
	for i=1, TARGETFRAMEBUFF_MAX_TARGET_BUFFS do
		buff = UnitBuff("target", i);
		button = getglobal("TargetFrameBuff"..i);
		if (buff) then
			getglobal("TargetFrameBuff"..i.."Icon"):SetTexture(buff);
			button:Show();
			button.id = i;
			num_buff = i;
		else
			button:Hide();
		end
	end

	local debuff, debuffApplication, debuffCount;
	for i=1, TARGETFRAMEBUFF_MAX_TARGET_DEBUFFS do
		debuff, debuffApplications = UnitDebuff("target", i);
		button = getglobal("TargetFrameDebuff"..i);
		if (debuff) then
			debuffCount = getglobal("TargetFrameDebuff"..i.."Count");
			if (debuffApplications > 1) then
				debuffCount:SetText(debuffApplications);
				debuffCount:Show();
			else
				debuffCount:Hide();
			end
			getglobal("TargetFrameDebuff"..i.."Icon"):SetTexture(debuff);
			button:Show();
			button.id = i;
			num_debuff = i;
		else
			button:Hide();
		end
	end
	
	-- Position buffs depending on whether the targeted unit is friendly or not
	if (UnitIsFriend("player", "target")) then
		TargetFrameBuff1:ClearAllPoints();
		TargetFrameBuff1:SetPoint("TOPLEFT", "TargetFrame", "BOTTOMLEFT", 5, 32);
		TargetFrameDebuff1:ClearAllPoints();
		TargetFrameDebuff1:SetPoint("TOPLEFT", "TargetFrameBuff"..TargetFrameBuff_Anchor(num_buff), "BOTTOMLEFT", 0, -2);
	else
		TargetFrameDebuff1:ClearAllPoints();
		TargetFrameDebuff1:SetPoint("TOPLEFT", "TargetFrame", "BOTTOMLEFT", 5, 32);
		TargetFrameBuff1:ClearAllPoints();
		TargetFrameBuff1:SetPoint("TOPLEFT", "TargetFrameDebuff"..TargetFrameBuff_Anchor(num_debuff), "BOTTOMLEFT", 0, -2);
	end

end


function TargetFrameBuff_Anchor(num)
	if (num > 5) then
		return 6;
	end
	return 1;
end


function TargetFrameBuff_Restore()
	TargetFrameDebuff6:ClearAllPoints();
	TargetFrameDebuff6:SetPoint("TOPLEFT", "TargetFrameDebuff1", "BOTTOMLEFT", 0, -2);
	TargetFrameDebuff7:ClearAllPoints();
	TargetFrameDebuff7:SetPoint("LEFT", "TargetFrameDebuff6", "RIGHT", 3, 0);
	TargetFrameDebuff11:ClearAllPoints();
	TargetFrameDebuff11:SetPoint("LEFT", "TargetFrameDebuff10", "RIGHT", 3, 0);

	-- Resize debuffs to full size
	local button, debuffFrame;
	for i=1, TARGETFRAMEBUFF_MAX_TARGET_DEBUFFS do
		button = getglobal("TargetFrameDebuff"..i);
		debuffFrame = getglobal("TargetFrameDebuff"..i.."Border");
		button:SetWidth(21);
		button:SetHeight(21);
		debuffFrame:SetWidth(23);
		debuffFrame:SetHeight(23);
	end
end