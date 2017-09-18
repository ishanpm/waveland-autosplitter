state("WaveLand_Project")
{
	short levelComplete : 0x0039AF04, 0x0, 0x40, 0xC, 0xB4;
	float playerX : 0x0039AEFC, 0xC, 0xB0, 0x8, 0x7C;
	// float playerY : 0x0039AEFC, 0xC, 0xB0, 0x8, 0x80;
	short levelNum : 0x0059D310;
	short teleport : 0x0039C2D4, 0x40, 0x20; // Not exactly sure what this does but it works
}

startup
{
	settings.Add("start", false, "Start on new file (Not available)");
	settings.SetToolTip("start", @"WIP");
	settings.Add("enter", true, "Split on entering levels");
	settings.Add("enter1", true, "Split on entering 1-1", "enter");
	settings.Add("enterany", false, "Split on entering any other level", "enter");
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
		
		if (current.playerX > 1695 && current.playerX < 1809) {
			if (settings["finish"]) {
				vars.DebugOutput("Finish");
				return true;
			}
		} else if (settings["enter"]) {
			if (current.playerX > 1318 && current.playerX < 1368) {
				vars.DebugOutput("Split Start of 1-1");
				return settings["enter1"];
			} else if (current.playerX > 1318) {
				vars.DebugOutput("Split Start of level");
				return settings["enterany"];
			}
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
