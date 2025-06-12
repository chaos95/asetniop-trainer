

format = function(template, args)
    outString = ""
    varName = ""
    inVar = false
    for char in template
        if inVar and char != "}" then
            varName = varName + char
        else if inVar and char == "}" then
            inVar = false
            outString = outString + args[varName]
        else if char == "{" then
            inVar = true
            varName = ""
        else
            outString = outString + char
        end if
    end for
    return outString
end function