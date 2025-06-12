import "utils"
ensureImport "textUtils"
ensureImport "vector"
ensureImport "math"

SCREEN_WIDTH = 68
PAGE_WIDTH = 80
MARGIN_WIDTH = 6
FEED_LINES = 4
FULL_PAGE_WIDTH = MARGIN_WIDTH + PAGE_WIDTH + MARGIN_WIDTH
CARRIAGE_START = MARGIN_WIDTH
CARRIAGE_STOP = MARGIN_WIDTH + PAGE_WIDTH
BLANK_ROW = " " * FULL_PAGE_WIDTH

PAGE_COLOR = color.silver
ACTIVETEXT_COLOR = color.black
INACTIVETEXT_COLOR = color.gray

Typewriter = {}

Typewriter.init = function(textDisplay, caret_pos)
    self.text = textDisplay
    self.page = [BLANK_ROW] * FEED_LINES
    self.row = BLANK_ROW
    self.carriage = CARRIAGE_START
    self.caret_pos = caret_pos
    self.debug = false
end function

Typewriter.backspace = function
    if self.carriage > CARRIAGE_START then
        self.carriage = self.carriage - 1
    end if
end function

Typewriter.typeChar = function(char)
    if self.carriage >= CARRIAGE_STOP then
        return
    end if 
    if char.len > 1 then char = char[0]
    self.row = self.row[:self.carriage] + char + self.row[self.carriage+1:]
    self.carriage = self.carriage + 1
end function

Typewriter.newLine = function
    self.page.push self.row
    self.carriage = MARGIN_WIDTH
    self.row = BLANK_ROW
end function

Typewriter.printPage = function
    self.text.backColor = "#000000FF"
    self.text.clear
    for index in range(self.page.len)
        line = self.page[-index]
        self.printLine line, self.caret_pos.plus(Vec2.make(0,index))
    end for
    self.printLine self.row, self.caret_pos
    for x in range(self.caret_pos.x, SCREEN_WIDTH)
        self.text.setCellColor x, self.caret_pos.y, INACTIVETEXT_COLOR
    end for
end function

Typewriter.printLine = function(line, pos)
    self.text.backColor = PAGE_COLOR
    self.text.color = ACTIVETEXT_COLOR

    outputLine = line[math.clamp(self.carriage - pos.x, 0, FULL_PAGE_WIDTH):]
    printPosition = Vec2.make(math.clamp(pos.x-self.carriage, 0, SCREEN_WIDTH), pos.y)
    printLength = math.clamp(SCREEN_WIDTH - printPosition.x, 0, outputLine.len)

    self.text.printAt printPosition, outputLine[:printLength]
    if self.debug then
        self.text.printAt Vec2.make(0,0), "pp:(" + printPosition.x + "," + printPosition.y + ") pl:" + printLength + " c:" + self.carriage
    end if
end function