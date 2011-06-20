(define string-to-num
	(ruby_func "
		lambda { |arguments, interpreter|
			interpreter.evaluate(arguments[0]).to_i
		}
	")
)