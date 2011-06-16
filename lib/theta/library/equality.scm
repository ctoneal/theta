(define =
	(ruby_func "
		lambda { |arguments, interpreter|
			arguments.each do |arg|
				if not interpreter.evaluate(arg) == interpreter.evaluate(arguments[0])
					return false
				end
			end
			return true
		}
	")
)