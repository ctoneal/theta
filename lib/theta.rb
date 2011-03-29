require File.expand_path(File.join(File.dirname(__FILE__), "theta", "interpreter.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "theta", "environment.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "theta", "parser.rb"))

module Theta
	# runs the interpreter
	class Base
	
		def initialize
			@interpreter = Interpreter.new
		end
		
		# run a preexisting program
		def run(fileName)
			program = File.open(fileName) { |f| f.read }
			puts @interpreter.run(program)
		end
		
		# start an interactive interpreter
		def repl
			while true
				print "theta> "
				input = ""
				input << gets.strip
				if input == "exit"
					puts "Exiting..."
					return
				end
				if input.empty?
					next
				end
				value = @interpreter.run(input)
				unless value.nil?
					puts @interpreter.make_readable(value)
				end
			end
		end
	end
end
