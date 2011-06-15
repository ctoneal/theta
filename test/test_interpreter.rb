require 'helper'

module Theta
	class TestInterpreter < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end
		
		context "run" do
			should "run code and return a result" do
				result = @interpreter.run("(+ 0 1)")
				assert_equal(1, result[0])
			end
		end
		
		context "evaluate" do
			should "allow definition of items" do
				@interpreter.evaluate([:define, :a, 1])
				assert_equal(1, @interpreter.current_environment.find(:a))
			end
			
			should "allow ruby functions" do
				result = @interpreter.evaluate([:ruby_func,
				"lambda { 1 }"])
				assert_equal(1, result.call)
			end
		end
	end
end
