on run argv
  tell application "Skype"
    send command "GET CHAT " & item 1 of argv & " TOPIC" script name "capistrano-skype"
  end tell
end run
