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

term.write("Gambo OS V3.0:")
term.setCursorPos(33,1)
shell.run("id")

-- This function performs the given operation on the two operands
function calculate(operand1, operator, operand2)
  if operator == "+" then
    return operand1 + operand2
  elseif operator == "-" then
    return operand1 - operand2
  elseif operator == "" then
    return operand1 - operand2
  elseif operator == "/" then
    return operand1 / operand2
  else
    -- If the operator is not recognized, return nil
    return nil
  end
end

-- Prompt the user for operand1, operator, and operand2
print("Enter the first operand:")
local operand1 = tonumber(read())

print("Enter the operator (+, -, *, /):")
local operator = read()

print("Enter the second operand:")
local operand2 = tonumber(read())

-- Calculate the result and print it
local result = calculate(operand1, operator, operand2)
if result then
    if operand1 == 1 and operator == "+" and operand2 == 1 then
        print("Result: FISH!")
    elseif result == "69" or "96" then
        print("Result: " .. result, "nice.")
    else
        print("Result: " .. result)
    end
else
  print("Invalid operator")
end

os.pullEvent("mouse_click") 
  term.setTextColor(colors.white)
  shell.execute("os/menus/utils")