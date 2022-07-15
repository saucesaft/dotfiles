on count_windows_on_current_space(process_name)
    tell application "System Events"
        tell process process_name
            return count of windows
        end tell
    end tell
end count_windows_on_current_space

tell application "iTerm2"
    if my count_windows_on_current_space("iTerm2") = 0 then
	create window with default profile
        activate
    else
	do shell script "open -a iTerm"
    end if
end tell
