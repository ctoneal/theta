module Theta
	# interpret scheme code
	class Interpreter

		attr_accessor :current_environment
		
		#initialize the environment and the parser
		def initialize
			@global_environment = @current_environment = Environment.new
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
		def evaluate(expression)
			puts "expression: #{expression} class: #{expression.class}"
			if expression.is_a? Symbol
				puts "symbol"
				return @current_environment.find(expression)
			elsif not expression.is_a? Array
				puts "other"
				return expression
			end

			if expression.count == 1
				if expression.is_a? Symbol
					return @current_environment.find(expression)
				else
					return expression
				end
			end

			case expression[0]
			when :define
				return @current_environment.define(expression [1], evaluate(expression[2]))
			when :ruby_func
				#return eval expression[1]
				puts "exp: #{expression[1]}"
				ex = eval expression[1]
				puts "return #{ex}"
				return ex
			else
				function = evaluate(expression[0])
				puts "returned: #{function} class: #{function.class}"
				if function.is_a? Proc
					arguments = expression[1, expression.length]
					puts "args: #{arguments}"
					return function.call(arguments, self)
				else
					raise RuntimeError, "#{expression[0]} is not a function"
				end
			end
		end
	end
end
