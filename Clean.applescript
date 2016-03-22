global gAtc, gBtc

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		
		tell PT
			activate
			delay 0.5
			
			
			set frontmost to true
			-- Hide all floating windows
			(*click menu item 3 of menu 1 of menu bar item 12 of menu bar 1*)
			(*key code 13 using {command down, shift down, option down}*)
			delay 0.5
			set frontmost to true
			
			
			
			set MainWindowSize to size of window 1
			
			
			--select number of tracks
			set temp to display dialog "Enter number of tracks and click OK" default answer ""
			set number_of_denoise_tracks to the text returned of temp
			
			repeat until (size of window 1 is equal to MainWindowSize)
			end repeat
			
			delay 0.5
			-- switch Main Counter to Samples
			click menu item 5 of menu 1 of menu item 16 of menu 1 of menu bar item "View" of menu bar 1
			
			-- copy start TC of selection
			set gAtc to value of button 3 of toolbar 4 of window 1
			-- copy end TC of selection
			set gBtc to value of button 4 of toolbar 4 of window 1
			
			
			
			
			set frontmost to true
			
			delay 1
			-- delete fades of regions
			click menu item "Delete" of menu 1 of menu item "Fades" of menu 1 of menu bar item "Edit" of menu bar 1
			
			delay 0.5
			
			set frontmost to true
			
			-- uncheck Tab to Transients
			if value of button 9 of toolbar 3 of window 1 = "Selected" then
				click button 9 of toolbar 3 of window 1
			end if
			
			delay 0.5
			
			set frontmost to true
			
			delay 0.5
			-- select start of the first region
			key code 125 -- Arrow Down 
			key code 35 -- P
			key code 41 -- ; semicolon
			
			-- check of empty start
			key code 47 -- . Period
			key code 37 using {shift down} -- L
			delay 0.5
			key code 3 --  F
			delay 0.5
			key code 39 -- ' quote
			delay 0.5
			if value of button 3 of toolbar 4 of window 1 as number is equal to (gAtc + 1920) then
				key code 37 using {shift down} -- L
				delay 0.5
				key code 51 -- delete
			end if
			delay 0.5
			
			delay 0.5
			
			-- cycle of denoise
			repeat number_of_denoise_tracks times
				
				-- compare TC of cursor with end TC of selection
				
				set tc to value of button 1 of toolbar 4 of window 1
				
				delay 0.5
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
				
				key code 125 -- Arrow Down
				key code 41 -- ; semicolon
				key code 39 -- ' quote
				
			end repeat
			
			-- switch Main Counter to TimeCode
			click menu item 3 of menu 1 of menu item 16 of menu 1 of menu bar item "View" of menu bar 1
			
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
				
				
				-- select 3 frames for noise profile
				
				key code 47 -- . period
				key code 47 -- . period
				key code 47 -- . period
				key code 37 using {shift down} -- L
				delay 0.3
				(*key code 3 --  F
				delay 0.5*)
				set frontmost to true
				delay 0.1
				(*set wtc to value of button 3 of toolbar 4 of window 1 -- copy start TC of selection
				set ztc to value of button 4 of toolbar 4 of window 1 -- copy end TC of selection
				key code 46 -- M
				key code 46 -- M
				
				key code 51 -- delete
				
				key code 44 -- / slash
				key code 44 -- / slash
				key code 44 -- / slash
				key code 37 using {shift down} -- L 
				delay 0.5 
				if value of button 1 of toolbar 4 of window 1 as number is equal to (wtc + 0) then
					delay 1
					key code 51 -- delete
					delay 0.5
					key code 46 -- M
					key code 46 -- M
					key code 46 -- M
					delay 0.5
					key code 39 using {shift down} -- ' quote
					delay 0.5
					key code 3 --  F
					delay 0.5
					key code 44 -- / slash
					key code 44 -- / slash
					key code 51 -- delete
					delay 0.5
					key code 44 -- / slash
					key code 44 -- / slash
					delay 0.5
					key code 44 -- / slash
					key code 37 using {shift down} -- L 
					delay 0.5
					if value of button 1 of toolbar 4 of window 1 as number < (gAtc - 19200) then
						key code 39 -- ' quote
						(*key code 44 -- / slash
						key code 44 -- / slash
						delay 0.5*)
						key code 44 -- / slash
						key code 37 using {shift down} -- L 
						delay 0.5
					end if
				end if*)
				
				delay 0.5
				
				-- launch iZotope RX 4 Denoiser
				click menu item "iZotope RX 4 Denoiser" of menu 1 of menu item "Noise Reduction" of menu 1 of menu bar item "AudioSuite" of menu bar 1
				
				delay 2
				
				
				
				set frontmost to true
				
				delay 0.5
				
				-- launch LEARN
				click button "analyze" of window "Audio Suite: iZotope RX 4 Denoiser"
				
				set MainWindowSize to size of window "Audio Suite: iZotope RX 4 Denoiser"
				delay 0.5
				
				set frontmost to true
				
				delay 0.5
				key code 39 using {shift down} -- ' quote
				
				delay 1
				set frontmost to true
				
				-- copy start TC of selection
				set xtc to value of button 3 of toolbar 4 of window 2
				
				-- copy end TC of selection
				set ytc to value of button 4 of toolbar 4 of window 2
				
				delay 1
				
				-- launch RENDER
				click button "process" of window "Audio Suite: iZotope RX 4 Denoiser"
				
				
				repeat until (size of window 1 is equal to MainWindowSize)
				end repeat
				
				-- Hide all floating windows
				click menu item 3 of menu 1 of menu bar item 12 of menu bar 1
				delay 2
				
				-- select end of the region
				key code 126 -- Arrow Up
				
				-- check of the next region
				key code 47 -- . Period
				key code 37 using {shift down} -- L
				delay 0.1
				key code 3 --  F
				delay 0.5
				key code 39 -- ' quote
				delay 0.5
				if value of button 3 of toolbar 4 of window 1 as number is equal to (ytc + 1920) then
					key code 37 using {shift down} -- L
					key code 51 -- delete
				end if
				
				delay 0.5
				
			end tell
		end tell
	end tell
end denoise