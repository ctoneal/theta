require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper.rb"))

module Theta
	class TestDivide < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end

		should "divide numbers properly" do
			result = @interpreter.run("(/ 10 2)")
			assert_equal(5, result[0])
		end
		
		should "divide multiple numbers" do
			result = @interpreter.run("(/ 4 2 2)")
			assert_equal(1, result[0])
		end
		
		should "divide defined variables" do
			result = @interpreter.run(
			"(define a 4)
			 (define b 2)
			 (/ a b)")
			assert_equal(2, result[0])
		end
		
		should "properly round for integer division" do
			result = @interpreter.run("(/ 5 2)")
			assert_equal(2, result[0])
		end
		
		should "not round for float division" do
			result = @interpreter.run("(/ 5.0 2)")
			assert_equal(2.5, result[0])
		end
	end
end
