
printAt = function(col, row, s)
	text.row = row
	text.column = col
	text.delimiter = ""
	print s
	text.delimiter = char(12)
end function