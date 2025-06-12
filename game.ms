import "utils"
ensureImport "textUtils"
ensureImport "vector"

Game = {}
Game.init = function(chordEngine, typewriter, assistant)
    self.done = false
    self.assistant = assistant
    self.chordEngine = chordEngine
    self.typewriter = typewriter

    backspaceWrapper = function
        typewriter.backspace
    end function
    self.chordEngine.addHandler "backspace", @backspaceWrapper
    
    newlineWrapper = function
        typewriter.newLine
    end function
    self.chordEngine.addHandler "newLine", @newlineWrapper

    write = function(stroke)
        for char in stroke
           typewriter.typeChar char 
        end for
    end function
    self.chordEngine.addHandler "write", @write 
end function

Game.drawKeyboard = function(pos)
	c = text.color
    for keyDC in self.chordEngine.keyDisplay
        if self.chordEngine.isDown(keyDC.key) then
            if self.chordEngine.startKey == keyDC.key then
                text.color = color.orange
            else
                text.color = color.yellow
            end if
        else
            text.color = color.olive
        end if
        text.printAt pos.plus(keyDC.pos), keyDC.key
    end for
	text.color = c
end function

Game.update = function(delta)
    self.chordEngine.checkInput
    self.assistant.update delta
end function

Game.draw = function
    self.typewriter.printPage
    self.drawKeyboard Vec2.make(26, 7)
    self.assistant.draw
end function