(define set!
	(ruby_func "
		lambda { |arguments, interpreter|
			if interpreter.current_environment.find(arguments[0]).nil?
				raise 'Variable ' + arguments[0] + ' is undefined'
			end
			interpreter.current_environment.define(arguments[0], arguments[1])
		}
	")
)