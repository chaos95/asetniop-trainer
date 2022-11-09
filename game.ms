import "utils"
ensureImport "textUtils"

Game = {}
Game.init = function(chordEngine, typewriter, assistant)
    self.done = false
    self.assistant = assistant
    self.chordEngine = chordEngine
    self.typewriter = typewriter
    
    backspace = function
        outer.typewriter.backspace
    end function
    self.chordEngine.addHandler("backspace", @backspace)
    
    newLine = function
        outer.typewriter.newLine
    end function
    self.chordEngine.addHandler("newLine", @newLine)

    write = function(stroke)
        for char in stroke
           outer.typewriter.typeChar char 
        end for
    end function
    self.chordEngine.addHandler("write", @write)
end function

Game.drawKeyboard = function(row, col)
	c = text.color
    for key in self.chordEngine.systemKeys
        if self.chordEngine.isDown(key) then
            text.color = color.yellow
        else
            text.color = color.olive
        end if
        text.printAt col, row, key
        col = col + 2
    end for
	text.color = c
end function

Game.update = function(delta)
    self.chordEngine.checkInput
    self.assistant.update delta
end function

Game.draw = function
    self.drawKeyboard 11, 26
    self.assistant.draw
end function