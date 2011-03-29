(define lambda
	(ruby_func "
		Proc.new() do |arguments, interpreter|
			parameters = arguments[0]
			body = arguments[1, arguments.length]
			if parameters.is_a? Array
				if parameters.length != parameters.uniq.length
					raise 'Parameters declared more than once'
				end
			end
			
			lambda_environment = Theta::Environment.new(interpreter.current_environment)
			
			execute = Proc.new() do |body, environment, interpreter|
				interpreter.current_environment = environment
				result = nil
				body.each do |expression|
					result = interpreter.evaluate(expression)
				end
				interpreter.current_environment = environment.parent
				return result
			end
			if parameters.is_a? Array
				Proc.new() do |arguments, interpreter|
					parameters.each_index do |x|
						lambda_environment.define(parameters[x], interpreter.evaluate(arguments[x]))
					end
					execute.call(body, lambda_environment, interpreter)
				end
			elsif parameters.is_a? Symbol
				Proc.new() do |arguments, interpreter|
					arguments.map! { |x| interpreter.evaluate(x) }
					lambda_environment.define(parameters, arguments)
					execute.call(body, lambda_environment, interpreter)
				end
			end
		end
	")
)
