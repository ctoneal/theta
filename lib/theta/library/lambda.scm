(define lambda
	(ruby_func "
		lambda { |arguments, interpreter|
			parameters = arguments[0]
			body = arguments[1, arguments.length]
			if parameters.is_a? Array
				if parameters.length != parameters.uniq.length
					raise 'Parameters declared more than once'
				end
			end
			
			lambda_environment = Theta::Environment.new(interpreter.current_environment)
			
			execute = lambda { |body, environment, interpreter|
				interpreter.current_environment = environment
				result = nil
				body.each do |expression|
					result = interpreter.evaluate(expression)
				end
				interpreter.current_environment = environment.parent
				return result
			}
			if parameters.is_a? Array
				lambda { |arguments, interpreter|
					parameters.each_index do |x|
						lambda_environment.define(parameters[x], interpreter.evaluate(arguments[x]))
					end
					execute.call(body, lambda_environment, interpreter)
				}
			elsif parameters.is_a? Symbol
				lambda { |arguments, interpreter|
					arguments.map! { |x| interpreter.evaluate(x) }
					lambda_environment.define(parameters, arguments)
					execute.call(body, lambda_environment, interpreter)
				}
			end
		}
	")
)
