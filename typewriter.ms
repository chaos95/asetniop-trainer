import "utils"
ensureImport "chording"

printAt = function(row, col, s)
	text.row = row
	text.column = col
	text.delimiter = ""
	print s
	text.delimiter = char(13)
end function

row = ""

backspace = function
    globals.row = row[0:-1]
    printRow
end function

typeChar = function(char)
    globals.row = row + char
    printRow
end function

printRow = function
    if row.len > 34 then
        printAt 12, 0, row[-34:] 
    else
        offset = 34 - row.len
        printAt 12, 0, " " * offset 
        printAt 12, offset, row 
    end if
end function

checkInput = function
	chordUp = 1
    for inputKey in asetniop.inputKeys
        if key.pressed(inputKey) then
            asetniop.add inputKey 
            chordUp = 0
        end if
    end for
    drawKeyboard 9, 26 
	if chordUp then
		stroke = asetniop.finishStroke
        if stroke == "<BACKSPACE>" then
            backspace
        else
            for char in stroke
                typeChar char 
            end for
        end if
	end if
end function

drawKeyboard = function(row, col)
	c = text.color
    for key in asetniop.systemKeys
        if asetniop.chord[key] then
            text.color = color.yellow
        else
            text.color = color.olive
        end if
        printAt row, col, key
        col = col + 2
    end for
	text.color = c
end function

asetniop = new chording.AsetniopKeyboard
asetniop.init "qweruiop" 

done = false

normalTextColor = text.color
clear

// Main loop:
while not done
	checkInput
	yield
end while

text.row = 5
text.color = normalTextColor
wait 1
print
exit
