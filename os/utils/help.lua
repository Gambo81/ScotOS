os.pullEvent = os.pullEventRaw
term.clear()
image = paintutils.loadImage("/os/backgrounds/gray.nfp")
paintutils.drawImage(image, 1, 1)
term.setBackgroundColor(colors.gray)
term.setTextColor(2)
term.setCursorPos(1,1)

local function readColorFromFile()
    if not fs.exists("/text_color") then
        return 2
    end

    local colorFile = fs.open("/text_color", "r")
    local color = tonumber(colorFile.readLine())
    colorFile.close()

    return color
end

local function setTextColorFromFile()
    local textColor = readColorFromFile()
    term.setTextColor(textColor)
end

-- Call the function to set the text color
setTextColorFromFile()

print("This menu has been made to help you navigate Gambo OS.")
term.setCursorPos(1, 3)
print(" ")
term.setCursorPos(1, 4)
print("When you are in the command line you can use 'ls' so see all of the files and folders. You can use 'cd' and then the name of the folder you want to enter to enter a folder. You can use 'edit' and then the name of the file to edit the file. Rember to be in the right folder to use the edit file.")

os.pullEvent("mouse_click") 
    term.setTextColor(colors.white)
    return
shell.run("/os/menus/utils")