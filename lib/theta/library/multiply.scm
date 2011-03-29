(define *
	(ruby_func "
		Proc.new() do |arguments, interpreter|
			temp = arguments.map { |item| interpreter.evaluate(item) }
			temp.inject { |result, n| result * n}
		end
	")
)
