require File.expand_path(File.join(File.dirname(__FILE__), "theta", "interpreter.rb"))

module Theta
	# runs the interpreter
	class Base
	
		def initialize
			@interpreter = Interpreter.new
		end
		
		# load and run the given file
		def load_file(file_path)
			program = File.open(file_path) { |f| f.read }
			run program
		end
		
		# run given code
		def run(program)
			output =  @interpreter.run(program)
			if not output.nil? and not output.empty? 
				output.each { |value| puts @interpreter.make_readable(value) }
			end
		end
		
		# start an interactive interpreter
		def repl
			puts "For interpreter commands, type 'help'"
			indent_count = 0
			code = []
			while true
				print "theta> " + ("  " * indent_count)
				input = gets.chomp
				code << input
				temp_code = code.join(" ")
				open_parens = temp_code.count("(")
				close_parens = temp_code.count(")")
				if open_parens == close_parens
					case input
					when "clear"
						puts "Resetting environment..."
						@interpreter = Interpreter.new
					when "exit", 24.chr
						puts "Exiting..."
						return
					when "help"
						repl_help
					else
						begin
							output = @interpreter.run(code.join(" "))
							if not output.nil? and not output.empty? 
								output.each { |value| puts @interpreter.make_readable(value) }
							end
						rescue SyntaxError
						rescue RuntimeError => e
							puts "Undefined variable: #{e.message}"
						rescue NoMethodError, TypeError => e
							puts "Invalid operation: #{e.message}"
						ensure
							code = []
							indent_count = 0						
						end
					end
				elsif open_parens > close_parens
					indent_count = open_parens - close_parens
				else
					puts "Parentheses don't match.  Ignoring code."
					code = []
					indent_count = 0
				end
			end
		end
		
		def repl_help
			puts "'clear' resets the environment"
			puts "'exit' or Ctrl-X will exit the interpreter"
			puts "'help' will display this message"
		end
	end
end
