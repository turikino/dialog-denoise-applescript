
tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		
		tell PT
			activate
			set frontmost to true
			
			set a to value of button 3 of toolbar 4 of window 1 -- copy start TC of selection
			set b to value of button 4 of toolbar 4 of window 1 -- copy end TC of selection
			delay 0.5
			
			(*-- copy start TC of selection
			set temp_a to value of button 3 of toolbar 4 of window 1
			set a to text of temp_a
			-- copy end TC of selection
			set temp_b to value of button 4 of toolbar 4 of window 1
			set b to number of temp_b*)
			
			(*set a to my number_to_string(a)*)
			
			if value of button 9 of toolbar 3 of window 1 = "Selected" then
				click button 9 of toolbar 3 of window 1
			end if
			
			
			
			key code 126 -- Arrow Up	
			
			click button 1 of toolbar 4 of window 1
			delay 0.5
			click button 1 of toolbar 4 of window 1
			delay 2
			set value of button 1 of toolbar 4 of window 1 to a
			key code 36 -- enter
			(*key code 88 using {option down, shift down} -- 6
			delay 0.1*)
			key code 125 -- Arrow Down
			key code 41 -- ; semicolon
			
		end tell
	end tell
end tell

on number_to_string(this_number)
	set this_number to this_number as string
	if this_number contains "E+" then
		set x to the offset of ":" in this_number
		set y to the offset of "+" in this_number
		set z to the offset of "," in this_number
		set the decimal_adjust to characters (y - (length of this_number)) thru Â
			-1 of this_number as string as number
		if x is not 0 then
			set the first_part to characters 1 thru (x - 1) of this_number as string
		else
			set the first_part to ""
		end if
		set the second_part to characters (x + 1) thru (z - 1) of this_number as string
		set the converted_number to the first_part
		repeat with i from 1 to the decimal_adjust
			try
				set the converted_number to Â
					the converted_number & character i of the second_part
			on error
				set the converted_number to the converted_number & "0"
			end try
		end repeat
		return the converted_number
	else
		return this_number
	end if
end number_to_string
