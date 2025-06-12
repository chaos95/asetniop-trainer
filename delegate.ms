
Delegate = {}
Delegate.name = ""
Delegate.numArgs = 0
Delegate.make = function(name, numArgs = 0)
	retval = new Delegate
	retval.name = name
	retval.numArgs = numArgs
    retval.handlers = []
	return retval
end function

Delegate._noneHandler = function(handler)
	retval = function(args)
		handler
	end function
	return @retval
end function

Delegate._singleHandler = function(handler)
	retval = function(args)
		handler args[0]
	end function
	return @retval
end function

Delegate._doubleHandler = function(handler)
	retval = function(args)
		handler args[0], args[1]
	end function
	return @retval
end function

Delegate.add = function(handler)
    if self.numArgs == 0 then
        self.handlers.push Delegate._noneHandler(@handler)
    else if self.numArgs == 1 then
        self.handlers.push Delegate._singleHandler(@handler)
    else if self.numArgs == 2 then
        self.handlers.push Delegate._doubleHandler(@handler)
    end if
end function

Delegate.call = function(args)
	for handler in self.handlers
		handler(args)
	end for
end function


runUnitTests = function
	print "Unit testing: delegate"
	
	errorCount = 0
	assertEqual = function(actual, expected, note)
		if actual != expected then
			print "Unit test failure (" + testing + "): expected " + expected + ", got " + actual
			outer.errorCount = errorCount + 1
		end if
	end function
	
	testing = "create Delegate"
    testNoArgs = Delegate.make("testNoArgs", 0)
    assertEqual testNoArgs.name, "testNoArgs"
    assertEqual testNoArgs.numArgs, 0
    assertEqual testNoArgs.handlers, []

    testing = "add handler"
    noArgFunc = function
        outer.testVal = "Look ma, no args!"
    end function
    testNoArgs.add(@noArgFunc)
    assertEqual testNoArgs.handlers.len, 1
    
    testing = "call"
    testNoArgs.call []
    assertEqual testVal, "Look ma, no args!"

    testing = "create Delegate with args"
    test1Arg = Delegate.make("test1Arg", 1)
    assertEqual test1Arg.name, "test1Arg"
    assertEqual test1Arg.numArgs, 1
    assertEqual test1Arg.handlers, []

    testing = "add handler with args"
    oneArgFunc = function(arg)
        outer.testVal = "Look ma, one arg: " + arg
    end function
    test1Arg.add(@oneArgFunc)
    assertEqual test1Arg.handlers.len, 1

    testing = "call with args"
    test1Arg.call ["hello"]
    assertEqual testVal, "Look ma, one arg: hello"

    testing = ""
    test2Args = Delegate.make("test2Args", 2)
    assertEqual test2Args.name, "test2Args"
    assertEqual test2Args.numArgs, 2
    assertEqual test2Args.handlers, []
    twoArgFunc = function(arg1, arg2)
        outer.testVal = "Look ma, two args: " + arg1 + ", " + arg2
    end function
    test2Args.add(@twoArgFunc)
    test2Args.call ["foo", "bar"]
    assertEqual testVal, "Look ma, two args: foo, bar"
	
	if errorCount == 0 then
		print "All tests passed.  Yay!"
	else
		print errorCount + " error" + "s" * (errorCount!=1) + " found."
	end if
end function

if globals == locals then runUnitTests
