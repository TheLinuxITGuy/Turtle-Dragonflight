--tDFALLINONE = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDebug-2.0", "AceModuleCore-2.0", "AceConsole-2.0", "AceDB-2.0", "AceHook-2.1")
tDFALLINONE = AceLibrary("AceAddon-2.0"):new("AceDB-2.0")
tDFALLINONE.frame = CreateFrame("Frame", "tDFALLINONE", UIParent)

function tDFALLINONE:OnEnable()
	MacroFrame_LoadUI();
	tDFALLINONE.SetItemButtonCountOriginal = SetItemButtonCount
end