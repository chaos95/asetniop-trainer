import "utils"
ensureImport "textUtils"

HALF_SCREEN_WIDTH = 34

Typewriter = {}
Typewriter.init = function(caret_y)
    self.caret_y = caret_y
    self.row = ""
end function

Typewriter.backspace = function
    self.row = self.row[0:-1]
    self.printRow
end function

Typewriter.typeChar = function(char)
    self.row = self.row + char
    self.printRow
end function

Typewriter.printRow = function
    if self.row.len > HALF_SCREEN_WIDTH then
        text.printAt 0, self.caret_y, self.row[-HALF_SCREEN_WIDTH:] 
    else
        offsetSpace = " " * (HALF_SCREEN_WIDTH - self.row.len)
        text.printAt 0, self.caret_y, offsetSpace + self.row
    end if
end function