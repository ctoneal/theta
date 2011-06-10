require File.expand_path(File.join(File.dirname(__FILE__), "environment.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "parser.rb"))

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

		# run some code
		def run(program)
			expression = parse(program)
			return evaluate(expression)
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
			if expression.is_a? Symbol
				return @current_environment.find(expression)
			elsif not expression.is_a? Array
				return expression
			end

			if expression.count == 1
				if expression.is_a? Symbol
					return @current_environment.find(expression[0])
				else
					return expression[0]
				end
			end

			case expression[0]
			when :define
				return @current_environment.define(expression [1], evaluate(expression[2]))
			when :ruby_func
				return eval expression[1]
			else
				function = evaluate(expression[0])
				if function.is_a? Proc
					arguments = expression[1, expression.length]
					return function.call(arguments, self)
				else
					raise RuntimeError, "#{expression[0]} is not a function"
				end
			end
		end
	end
end
