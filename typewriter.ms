import "utils"
ensureImport "textUtils"
ensureImport "vector"
ensureImport "math"

HALF_SCREEN_WIDTH = 34
PAGE_WIDTH = 80

Typewriter = {}
Typewriter.page = []
Typewriter.row = " " * PAGE_WIDTH
Typewriter.carriage = 0
Typewriter.caret_pos = Vec2.make(34, 12)

Typewriter.backspace = function
    if self.carriage > 0 then
        self.carriage = self.carriage - 1
    end if
end function

Typewriter.typeChar = function(char)
    if self.carriage >= PAGE_WIDTH then
        return
    end if 
    self.row = self.row[:self.carriage] + char + self.row[self.carriage+1:]
    self.carriage = self.carriage + 1
end function

Typewriter.newLine = function
    self.page.push row
    self.carriage = 0
    self.row = " " * PAGE_WIDTH
end function

Typewriter.printRow = function
    rowStart = math.max(0, self.caret_pos.x - self.carriage)
    rowBeforeCaret = self.carriage - math.min(self.caret_pos.x, self.carriage)
    rowLength = math.min(68 - rowStart, PAGE_WIDTH - rowBeforeCaret)
    printPos = Vec2.make(rowStart, self.caret_pos.y)
    text.printAt printPos, self.row[rowBeforeCaret : rowBeforeCaret+rowLength]
    //text.printAt Vec2.make(0,0), "c:" + self.carriage + " rs:" + rowStart + " rl:" + rowLength + " rbc:" + rowBeforeCaret
end function