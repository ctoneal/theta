require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper.rb"))

module Theta
	class TestSubtract < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end
		
		should "subtract numbers properly" do
			result = @interpreter.run("(- 10 5)")
			assert_equal(5, result[0])
		end
		
		should "subtract multiple numbers" do
			result = @interpreter.run("(- 20 1 2 3 4 5)")
			assert_equal(5, result[0])
		end
		
		should "subtract defined variables" do
			result = @interpreter.run(
			"(define a 4)
			 (define b 2)
			 (- a b)")
			assert_equal(2, result[0])
		end
	end
end
