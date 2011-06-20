require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper.rb"))

module Theta
	class TestSet < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end
		
		should "set value of existing variable" do
			@interpreter.run("
				(define a 1)
				(set! a 2)
			")
			assert_equal(2, @interpreter.current_environment.find(:a))
		end
		
		should "raise an error if variable not defined" do
			assert_raise(TypeError) { @interpreter.run("(set! a 2)") }
		end
	end
end