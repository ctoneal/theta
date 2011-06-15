require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper.rb"))

module Theta
	class TestAdd < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end
		
		should "add numbers correctly" do
			result = @interpreter.run("(+ 2 2)")
			assert_equal(4, result[0])
		end
		
		should "add a series of numbers" do
			result = @interpreter.run("(+ 5 4 3 2 1)")
			assert_equal(15, result[0])
		end
		
		should "add defined variables" do
			result = @interpreter.run(
			"(define a 1)
			 (define b 2)
			 (+ a b)")
			assert_equal(3, result[0])
		end
	end
end
