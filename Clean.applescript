tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		
		tell PT
			activate
			set frontmost to true
			(*set MainWindowSize to size of window 1*)
			
			set temp to display dialog "Enter number of tracks and click OK" default answer ""
			set number_of_denoise_tracks to the text returned of temp
			
			delay 0.5
			
			set a to value of button 3 of toolbar 4 of window 1 -- copy start TC of selection
			set b to value of button 4 of toolbar 4 of window 1 -- copy end TC of selection
			(*-- Hide all floating windows
			click menu item 3 of menu 1 of menu bar item 12 of menu bar 1*)
			
			delay 0.5
			
			-- delete fades of regions
			click menu item "Delete" of menu 1 of menu item "Fades" of menu 1 of menu bar item "Edit" of menu bar 1
			delay 0.2
			
			(*set tc to "00:02:00:00.00"
			set value of button 3 of toolbar 4 of window 1 to tc*)
			
			(*-- copy start TC of selection
			set temp_a to value of button 3 of toolbar 4 of window 1
			set a to number item of temp_a
			-- copy end TC of selection
			set temp_b to value of button 4 of toolbar 4 of window 1
			set b to number item of temp_b*)
			
			delay 0.5
			
			set frontmost to true
			
			if value of button 9 of toolbar 3 of window 1 = "Selected" then
				click button 9 of toolbar 3 of window 1
			end if
			
			(*if value of button 11 of toolbar 3 of window 1 = "Selected" then
				click button 11 of toolbar 3 of window 1
			end if*)
			delay 0.5
			
			
			
			set frontmost to true
			
			delay 0.5
			
			key code 125 -- Arrow Down 
			key code 35 -- P
			key code 41 -- ; semicolon
			
			delay 0.5
			
			
			-- compare TC of cursor with end TC of selection
			
			set tc to value of button 1 of toolbar 4 of window 1
			
			delay 0.5
			repeat while tc < b
				if tc < b then
					my denoise()
					set tc to value of button 1 of toolbar 4 of window 1
					
				end if
			end repeat
			
			-- shift cursor down
			repeat while value of button 1 of toolbar 4 of window 1 > a
				if value of button 1 of toolbar 4 of window 1 > a then
					key code 37 -- L
				end if
			end repeat
			
			key code 125 -- Arrow Down
			key code 41 -- ; semicolon
			key code 39 -- ' quote
			
			(*if number_of_denoise_tracks > 1 then
					set value of button 1 of toolbar 4 of window 1 to a
					delay 0.1
					key code 41 -- ; semicolon
				end if*)
			
			
			display dialog "Denoise done!"
			(*if tc ³ b then
				
				display dialog "TC is over!"
			else
				display dialog " not work!"
			end if*)
			
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
				
				delay 0.5
				-- launch iZotope RX 4 Denoiser
				click menu item "iZotope RX 4 Denoiser" of menu 1 of menu item "Noise Reduction" of menu 1 of menu bar item "AudioSuite" of menu bar 1
				
				delay 2
				
				-- select 15 frames for noise profile
				
				key code 44 -- / slash
				key code 37 using {shift down} -- L
				delay 0.1
				key code 3 --  F
				delay 0.1
				key code 46 -- M
				key code 46 -- M
				click menu item "Delete" of menu 1 of menu item "Fades" of menu 1 of menu bar item "Edit" of menu bar 1
				key code 44 -- / slash
				key code 44 -- / slash
				key code 44 -- / slash
				key code 37 using {shift down} -- L 
				click button "analyze" of window "Audio Suite: iZotope RX 4 Denoiser"
				
				set MainWindowSize to size of window "Audio Suite: iZotope RX 4 Denoiser"
				delay 0.5
				
				set frontmost to true
				
				delay 0.5
				key code 39 using {shift down} -- ' quote
				delay 2
				click button "process" of window "Audio Suite: iZotope RX 4 Denoiser"
				
				
				repeat until (size of window 1 is equal to MainWindowSize)
				end repeat
				-- Hide all floating windows
				click menu item 3 of menu 1 of menu bar item 12 of menu bar 1
				delay 2
				key code 126 -- Arrow Up
				key code 48 -- TAB
				
			end tell
		end tell
	end tell
	
end denoise