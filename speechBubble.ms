
SpeechBubble = {}
SpeechBubble.init = function(tileDisplayLayer, pixelDisplayLayer, width, height)
    self.td = tileDisplayLayer
    self.pd = pixelDisplayLayer

    self.maxCol = width - 1
    self.maxRow = height - 1

    self.loadTileSet("/sys/pics/TwoCornerTiles.png", 64, 16)
    
    self.td.extent = [width, height]  // columns, rows on screen
end function

SpeechBubble.loadTileSet = function(path, tileSize, wangOffset)
    self.td.tileSet = file.loadImage("/sys/pics/TwoCornerTiles.png")
    self.td.tileSetTileSize = 64  // size of each tile in the image

    self.SW = 1 + wangOffset
    self.NW = 2 + wangOffset
    self.W = 3 + wangOffset
    self.NE = 4 + wangOffset
    self.N = 6 + wangOffset
    self.SE = 8 + wangOffset
    self.S = 9 + wangOffset
    self.E = 12 + wangOffset
    self.SOLID = 15 + wangOffset
end function

SpeechBubble.draw = function(pos, firstLine = "", secondLine = "")
    td = self.td
    td.clear self.SOLID

    td.scrollX = -pos.x
    td.scrollY = -pos.y

    for col in range(1, self.maxCol - 1)
        td.setCell col, 0,           self.S
        td.setCell col, self.maxRow, self.N
    end for
    for row in range(1, self.maxRow - 1)
        td.setCell 0,           row, self.W
        td.setCell self.maxCol, row, self.E
    end for
    
    td.setCell 0,           0,           self.SW
    td.setCell 0,           self.maxRow, self.NW
    td.setCell self.maxCol, 0,           self.SE
    td.setCell self.maxCol, self.maxRow, self.NE

    fontSize = 24
    tileSize = self.td.tileSetTileSize
    textX = pos.x + (1 * tileSize)
    textY = pos.y + ((self.maxRow) * tileSize) - fontSize
    self.pd.print(firstLine, textX, textY)
    self.pd.print(secondLine, textX, textY - fontSize)
end function
