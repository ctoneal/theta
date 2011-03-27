module Theta
	# interpret scheme code
	class Interpreter

		#initialize the environment and the parser
		def initialize
			@global_environment = Environment.new
			@parser = Parser.new
			load_library
		end

		# load any predefined library files
		def load_library
			library_directory = File.expand_path(File.join(File.dirname(__FILE__), "library"))
			Dir.foreach(library_directory) do |file|
				if file != "." && file != ".."
					f = File.open(File.join(library_directory, file))
					run(f.read)
				end
			end
		end

		# run a line of code
		def run(program)
			expressions = parse(program)
			return evaluate(expressions)
		end

		# call the parser to make a string interpretable
		def parse(string)
			@parser.parse(string)
		end

		# call the parser to make something readable
		def make_readable(value)
			@parser.to_string(value)
		end

		# evaluate the scheme expression
		def evaluate(expression, environment=@global_environment)
			if expression.is_a? Symbol
				return environment.find(expression)
			elsif not expression.is_a? Array
				return expression
			end
			case expression[0]
			when :define
				return environment.define(expression [1], evaluate(expression[2], environment))
			when :ruby_func
				return eval expression[1]
			else
				function = evaluate(expression[0], environment)
				if function.lambda?
					arguments = expression[1, expression.length]
					function.call(arguments, self)
				else
				end
			end
		end
	end
end
