(define >
	(ruby_func "
		lambda { |arguments, interpreter|
			args_to_compare = arguments[1, arguments.length]
			args_to_compare.each do |arg|
				if not interpreter.evaluate(arguments[0]) > interpreter.evaluate(arg)
					return false
				end
			end
			return true
		}
	")
)