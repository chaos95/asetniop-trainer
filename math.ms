min = function(a, b)
    if a < b then return a
    return b
end function

max = function(a, b)
    if a > b then return a
    return b
end function

clamp = function(x, minval, maxval)
    if x < minval then return minval
    if x > maxval then return maxval
    return x
end function