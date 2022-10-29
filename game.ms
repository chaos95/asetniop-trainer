import "utils"
ensureImport "textUtils"

Game = {}
Game.init = function(chordEngine, outputEngine)
    self.chordEngine = chordEngine
    self.outputEngine = outputEngine
end function

Game.run = function
    done = false
    // Main loop:
    while not done
        self.checkInput
        yield
    end while
end function

Game.checkInput = function
	chordUp = 1
    for inputKey in self.chordEngine.inputKeys
        if key.pressed(inputKey) then
            self.chordEngine.add inputKey 
            chordUp = 0
        end if
    end for
    self.drawKeyboard 9, 26 
	if chordUp then
		stroke = self.chordEngine.finishStroke
        if stroke == "<BACKSPACE>" then
            self.outputEngine.backspace
        else
            for char in stroke
                self.outputEngine.typeChar char 
            end for
        end if
	end if
end function

Game.drawKeyboard = function(row, col)
	c = text.color
    for key in self.chordEngine.systemKeys
        if self.chordEngine.chord[key] then
            text.color = color.yellow
        else
            text.color = color.olive
        end if
        textUtils.printAt col, row, key
        col = col + 2
    end for
	text.color = c
end function
