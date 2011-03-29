(define /
	(ruby_func "
		lambda { |arguments, interpreter|
			temp = arguments.map { |item| interpreter.evaluate(item) }
			temp.inject { |result, n| result / n}
		}
	")
)
