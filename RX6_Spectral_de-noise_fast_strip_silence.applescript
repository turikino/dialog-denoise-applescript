global gAtc, gBtc, xClick, yClick, xStartMAutoInsert, yStartMAutoInsert, xStartMAutoSuite, yStartMAutoSuite, xStartRX6Denoise, yStartRX6Denoise, EditWindowSize, RX6WindowSize, numberOfZ

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		
		tell PT
			activate
			delay 0.3
			
			
			set frontmost to true
			(*-- Hide all floating windows
			click menu item 3 of menu 1 of menu bar item 12 of menu bar 1*)
			(*key code 13 using {command down, shift down, option down}*)
			delay 0.3
			set frontmost to true
			
			set EditWindowSize to size of window 1
			
			--select number of tracks
			set temp to display dialog "Enter number of tracks and click OK" default answer ""
			set number_of_denoise_tracks to the text returned of temp
			repeat until (size of window 1 is equal to EditWindowSize)
			end repeat
			
			set frontmost to true
			
			delay 0.3
			
			-- switch Main Counter to Samples
			click menu item 5 of menu 1 of menu item 16 of menu 1 of menu bar item "View" of menu bar 1
			
			-- check Play Loop
			if value of button 7 of toolbar 1 of toolbar 6 of window 1 = "loop" then
				key code 37 using {shift down, command down} -- shift,cmd+L
			end if
			
			-- copy start TC of selection
			set gAtc to value of button 3 of toolbar 4 of window 1
			-- copy end TC of selection
			set gBtc to value of button 4 of toolbar 4 of window 1
			
			set frontmost to true
			
			delay 0.3
			-- delete fades of regions
			click menu item "Delete" of menu 1 of menu item "Fades" of menu 1 of menu bar item "Edit" of menu bar 1
			
			delay 0.3
			
			set frontmost to true
			
			-- uncheck Tab to Transients
			if value of button 9 of toolbar 3 of window 1 = "Selected" then
				click button 9 of toolbar 3 of window 1
			end if
			
			delay 0.3
			--select strip silence
			key code 32 using {command down} -- cmd+U
			set stripWindow to size of window 1
			delay 0.3
			set value of value indicator 1 of slider 1 of window 1 to 0.04
			set value of value indicator 1 of slider 2 of window 1 to 0.04
			set value of value indicator 1 of slider 3 of window 1 to 0.03
			--select threshold of strip silence
			set temp to display dialog "Enter theshhold of Strip silence and click OK" default answer ""
			set threshDb to the text returned of temp
			repeat until (size of window 1 is equal to stripWindow)
			end repeat
			if threshDb � 0 then
				set value of value indicator 1 of slider 4 of window 1 to (-threshDb / 98 + 1)
			end if
			delay 0.5
			set frontmost to true
			delay 0.5
			key code 32 using {command down} -- cmd+U
			set frontmost to true
			
			delay 0.3
			-- select start of the first region
			key code 125 -- Arrow Down 
			key code 35 -- P
			key code 41 -- ; semicolon
			
			
			(*
-- check of empty start
			key code 47 -- . Period
			key code 37 using {shift down} -- L
			delay 0.3
			key code 3 --  F
			delay 0.3
			key code 39 -- ' quote
			delay 0.3
			if value of button 3 of toolbar 4 of window 1 as number is equal to (gAtc + 1920) then
				key code 37 using {shift down} -- L
				delay 0.3
				key code 51 -- delete
			end if
			delay 0.3
			
*)
			
			-- cycle of denoise
			repeat number_of_denoise_tracks times
				
				-- compare TC of cursor with end TC of selection
				
				set tc to value of button 1 of toolbar 4 of window 1
				
				delay 0.3
				repeat while tc < gBtc
					if tc < gBtc then
						my denoise()
						set tc to value of button 1 of toolbar 4 of window 1
					end if
				end repeat
				
				-- shift cursor down
				repeat while value of button 1 of toolbar 4 of window 1 > gAtc
					if value of button 1 of toolbar 4 of window 1 > gAtc then
						key code 37 -- L
					end if
				end repeat
				
				(*key code 125 -- Arrow Down
				delay 0.3*)
				key code 41 -- ; semicolon
				
				repeat while value of button 1 of toolbar 4 of window 1 < gAtc
					if value of button 1 of toolbar 4 of window 1 < gAtc then
						key code 39 -- ' quote
					end if
				end repeat
			end repeat
			
			-- switch Main Counter to TimeCode
			click menu item 3 of menu 1 of menu item 16 of menu 1 of menu bar item "View" of menu bar 1
			
			(*-- Restore all floating windows
			click menu item 3 of menu 1 of menu bar item 12 of menu bar 1
			delay 2*)
			
			display dialog "Denoise done!"
			
		end tell
	end tell
end tell

on denoise()
	tell application "Finder"
		tell application "System Events"
			set PT to the first application process whose creator type is "PTul"
			
			tell PT
				activate
				set frontmost to true
				
				if value of button 1 of toolbar 4 of window 1 < gAtc then
					key code 39 -- ' quote
				end if
				
				-- check of empty start
				set startRegion to value of button 1 of toolbar 4 of window 1
				key code 47 -- . Period
				key code 37 using {shift down} -- L
				delay 0.3
				key code 3 --  F
				delay 0.3
				key code 39 -- ' quote
				delay 0.3
				if value of button 1 of toolbar 4 of window 1 as number = (startRegion + 1920) then
					key code 37 using {shift down} -- L
					delay 0.3
					key code 51 -- delete
				end if
				
				if value of button 1 of toolbar 4 of window 1 < gAtc then
					key code 39 -- ' quote
				end if
				delay 0.3
				key code 39 using {shift down} -- ' quote
				delay 0.3
				
				-- copy start TC of selection
				set xtc to value of button 3 of toolbar 4 of window 1
				
				-- copy end TC of selection
				set ytc to value of button 4 of toolbar 4 of window 1
				
				--select strip silence
				key code 32 using {command down} -- cmd+U
				delay 0.3
				click button 4 of window 1
				delay 0.3
				key code 32 using {command down} -- cmd+U
				key code 125 -- Arrow Down 
				
				set frontmost to true
				
				-- check of empty start
				
				key code 47 -- . Period
				key code 37 using {shift down} -- L
				delay 0.3
				key code 3 --  F
				delay 0.3
				key code 39 -- ' quote
				delay 0.3
				
				if value of button 1 of toolbar 4 of window 1 = (xtc + 1920) then
					set numberOfZ to 3
					delay 0.3
					key code 37 using {shift down} -- L
					delay 0.3
					key code 51 -- delete
				else if value of button 1 of toolbar 4 of window 1 � (ytc) then
					set numberOfZ to 0
					key code 6 -- z
					key code 125 -- Arrow Down
				else if value of button 1 of toolbar 4 of window 1 = xtc then
					set numberOfZ to 1
				end if
				
				-- select 3 frames for noise profile
				key code 47 -- . period
				key code 47 -- . period
				key code 47 -- . period
				key code 37 using {shift down} -- L
				
				set frontmost to true
				delay 0.3
				
				-- launch RX 6 Spectral De-noise
				click menu item "RX 6 Spectral De-noise" of menu 1 of menu item "Noise Reduction" of menu 1 of menu bar item "AudioSuite" of menu bar 1
				
				delay 0.3
				
				set frontmost to true
				
				-- launch LEARN
				click button "analyze" of window "Audio Suite: RX 6 Spectral De-noise"
				
				set RX6WindowSize to size of window "Audio Suite: RX 6 Spectral De-noise"
				
				delay 0.3
				
				set frontmost to true
				
				delay 0.3
				
				repeat numberOfZ times
					key code 6 -- z
					delay 0.3
				end repeat
				delay 0.3
				if numberOfZ = 0 then
					key code 39 using {shift down} -- ' quote
				end if
				
				delay 0.3
				
				(*
-- copy start TC of selection
				set xtc to value of button 3 of toolbar 4 of window 2
				
				-- copy end TC of selection
				set ytc to value of button 4 of toolbar 4 of window 2
*)
				
				
				delay 0.3
				
				-- launch RENDER
				click button "process" of window 1
				repeat until (size of window 1 is equal to RX6WindowSize)
				end repeat
				
				(*-- Hide all floating windows
				click menu item 3 of menu 1 of menu bar item 12 of menu bar 1*)
				delay 0.3
				-- close RX Denoiser
				(*click button 1 of window "Audio Suite: RX 6 Spectral De-noise"*)
				repeat until size of window 1 = EditWindowSize
					click button 1 of window 1
					delay 0.3
				end repeat
				
				delay 0.3
				
				-- select end of the region
				key code 126 -- Arrow Up
				delay 0.3
				
			end tell
		end tell
	end tell
end denoise

on clickMouse()
	-- move the mouse to the x/y coordinates in 100 steps
	
	set mouseToolsPath to (path to home folder as text) & "UnixBins:MouseTools"
	
	set x to xClick
	
	set y to yClick
	
	do shell script quoted form of POSIX path of mouseToolsPath & " -x " & (x as text) & " -y " & (y as text) & " -mouseSteps 200"
	delay 0.3
	do shell script quoted form of POSIX path of mouseToolsPath & " -x " & (x as text) & " -y " & (y as text) & " -leftClickNoRelease"
	delay 0.3
	do shell script quoted form of POSIX path of mouseToolsPath & " -x " & (x as text) & " -y " & (y as text) & " -releaseMouse"
	
end clickMouse