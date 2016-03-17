tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		
		tell PT
			activate
			set frontmost to true
			(*set MainWindowSize to size of window 1*)
			
			set temp to display dialog "Enter number of tracks and click OK" default answer ""
			set text_user_entered to the text returned of temp
			
			set frontmost to true
			
			repeat until (size of window 1 is equal to MainWindowSize)
			end repeat
			delay 0.5
			-- delete fades of regions
			click menu item "Delete" of menu 1 of menu item "Fades" of menu 1 of menu bar item "Edit" of menu bar 1
			delay 0.2
			
			(*set tc to "00:02:00:00.00"
			set value of button 3 of toolbar 4 of window 1 to tc*)
			
			
			(*set a to value of button 3 of toolbar 4 of window 1 -- copy start TC of selection
			set b to value of button 3 of toolbar 4 of window 1 -- copy end TC of selection
			
			delay 0.5*)
			
			if value of button 9 of toolbar 3 of window 1 = "Selected" then
				click button 9 of toolbar 3 of window 1
			end if
			delay 0.5
			(*f value of button 9 of toolbar 3 of window 1 = "" then
				display dialog "TC is over!"
			end if*)
			
			set frontmost to true
			-- launch iZotope RX 4 Denoiser
			click menu item "iZotope RX 4 Denoiser" of menu 1 of menu item "Noise Reduction" of menu 1 of menu bar item "AudioSuite" of menu bar 1
			delay 0.5
			
			key code 125 -- Arrow Down 
			key code 35 -- P
			key code 41 -- ; semicolon
			
			
			
			
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
			
			(*-- compare TC of cursor with end TC of selection
			set c to value of button 1 of toolbar 4 of window 1
			delay 0.5
			if c > b then
				display dialog "TC is over!"
			end if *)
			
			(*on denoise {}
			click button "analyze" of window "Audio Suite: iZotope RX 4 Denoiser"
			delay 0.5
			
			set frontmost to true
			
			delay 0.5
			key code 39 using {shift down} -- ' quote
			
			click button "process" of window "Audio Suite: iZotope RX 4 Denoiser"
			
			
			repeat until (size of window 1 is equal to MainWindowSize)
				end repeat
			end denoise
			*)
			
			click button "analyze" of window "Audio Suite: iZotope RX 4 Denoiser"
			delay 0.5
			
			set frontmost to true
			
			delay 0.5
			key code 39 using {shift down} -- ' quote
			
			click button "process" of window "Audio Suite: iZotope RX 4 Denoiser"
			
			
			repeat until (size of window 1 is equal to MainWindowSize)
			end repeat
			
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
			delay 0.5
			
		end tell
	end tell
end tell