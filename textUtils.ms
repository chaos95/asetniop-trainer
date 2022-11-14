
TextDisplay.printAt = function(pos, s)
	prevrow = self.row
	prevcolumn = self.column
	self.row = pos.y
	self.column = pos.x
	self.delimiter = ""
	self.print s
	self.delimiter = char(12)
	self.row = prevrow
	self.column = prevcolumn
end function