(define if
	(ruby_func "
		lambda { |arguments, interpreter|
			if interpreter.evaluate(arguments[0])
				interpreter.evaluate(arguments[1])
			else
				if not arguments[2].nil?
					interpreter.evaluate(arguments[2])
				end
			end
		}
	")
)