state("WaveLand_Project")
{
	short levelComplete : 0x0039AF04, 0x0, 0x190, 0xC, 0x48, 0x254;
	float playerX : 0x0039AEFC, 0xC, 0xB0, 0x8, 0x7C;
	short levelNum : 0x0059D310;
	short teleport : 0x0039C2D4, 0x40, 0x20; // Not exactly sure what this does but it works
}

startup
{
	settings.Add("start", false, "Start on new file (WIP)");
	settings.SetToolTip("start", @"WIP");
	settings.Add("enter1", true, "Split on entering first level");
	settings.Add("level", true, "Split on completing a level");
	settings.Add("finish", true, "Split on entering final cutscene");

	Action<string> DebugOutput = (text) => {
		print("[Waveland Demo Autosplitter] "+text);
	};
	vars.DebugOutput = DebugOutput;
	
	vars.DebugOutput("Hello world");
}

// Known values for levelNum:
// 2  - Title
// 6  - Overworld
// 13 - 1-1
// 14 - 1-2
// 15 - 1-3
// 16 - 1-4
// 17 - 1-5
// 18 - 1-6
// 19 - 1-7
// 18 - 1-8
// 23 - Secret level


split
{
	if (current.teleport > old.teleport && current.levelNum == 6) {
		vars.DebugOutput("Teleport x=" + current.playerX);
		
		// Determine which teleporter was used based on player X
		
		if (settings["enter1"] && current.playerX > 1318 && current.playerX < 1368) {
			vars.DebugOutput("Split Start of 1-1");
			return true;
		}
		
		if (settings["finish"] && current.playerX > 1695 && current.playerX < 1809) {
			vars.DebugOutput("Finish");
			return true;
		}
	}
	
	//vars.DebugOutput(current.levelComplete);
	if (current.levelComplete == 1 && old.levelComplete == 0)
	{
		print("[Waveland Demo Autosplitter] Level Complete");
		 
		if (settings["level"])
		{
			vars.DebugOutput("Split End of Level");
			return true;
		}
	}
	
	return false;
}
