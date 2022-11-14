Vec2 = {}
Vec2.x = 0
Vec2.y = 0
Vec2.make = function(x, y)
	retval = new Vec2
	retval.x = x
	retval.y = y
	return retval
end function

Vec2.origin = function
	return Vec2.make(0, 0)
end function

Vec2.plus = function(other)
	return Vec2.make(self.x + other.x, self.y + other.y)
end function


globals["Vec2"] = Vec2