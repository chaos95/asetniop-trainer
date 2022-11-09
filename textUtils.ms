
TextDisplay.printAt = function(col, row, s)
	prevrow = self.row
	prevcolumn = self.column
	self.row = row
	self.column = col
	self.delimiter = ""
	self.print s
	self.delimiter = char(12)
	self.row = prevrow
	self.column = prevcolumn
end function