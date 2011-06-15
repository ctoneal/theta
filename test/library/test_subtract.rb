require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper.rb"))

module Theta
	class TestSubtract < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end
		
		should "subtract numbers properly" do
			result = @interpreter.run("(- 10 5)")
			assert_equal(5, result)
		end
		
		should "subtract multiple numbers" do
			result = @interpreter.run("(- 20 1 2 3 4 5)")
			assert_equal(5, result)
		end
		
		should "subtract defined variables" do
			@interpreter.run("(define a 1)")
			@interpreter.run("(define b 2)")
			result = @interpreter.run("(- b a)")
			assert_equal(1, result)
		end
	end
end
