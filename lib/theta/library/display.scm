(define display
	(ruby_func "
		lambda { |arguments, interpreter|
			output = interpreter.evaluate(arguments[0])
			puts interpreter.make_readable(output)
		}
	")
)