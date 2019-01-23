global gAtc, gBtc, xClick, yClick, xStartMAutoInsert, yStartMAutoInsert, xStartMAutoSuite, yStartMAutoSuite, xStartRX6Denoise, yStartRX6Denoise

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		
		tell PT
			activate
			delay 0.5
			
			
			set frontmost to true
			
			delay 0.5
			-- switch Main Counter to Timecode
			click menu item 3 of menu 1 of menu item 16 of menu 1 of menu bar item "View" of menu bar 1
			
			-- switch Main Counter to TimeCode
			click menu item 3 of menu 1 of menu item 16 of menu 1 of menu bar item "View" of menu bar 1
			
			-- check Insertion Follows Playback
			if value of button 13 of toolbar 3 of window 1 = "Selected" then
				click button 13 of toolbar 3 of window 1
			end if
			
			-- check Play Loop
			if value of button 7 of toolbar 1 of toolbar 6 of window 1 = "loop" then
				key code 37 using {shift down, command down} -- shift,cmd+L
			end if
			
			
			display dialog "Restore settings done!"
			
		end tell
	end tell
end tell


on clickMouse()
	-- move the mouse to the x/y coordinates in 100 steps
	
	set mouseToolsPath to (path to home folder as text) & "UnixBins:MouseTools"
	
	set x to xClick
	
	set y to yClick
	
	do shell script quoted form of POSIX path of mouseToolsPath & " -x " & (x as text) & " -y " & (y as text) & " -mouseSteps 200"
	delay 0.5
	do shell script quoted form of POSIX path of mouseToolsPath & " -x " & (x as text) & " -y " & (y as text) & " -leftClickNoRelease"
	delay 0.3
	do shell script quoted form of POSIX path of mouseToolsPath & " -x " & (x as text) & " -y " & (y as text) & " -releaseMouse"
	
end clickMouse