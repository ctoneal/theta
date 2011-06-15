require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper.rb"))

module Theta
	class TestMultiply < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end
		
		should "multiply numbers properly" do
			result = @interpreter.run("(* 2 2)")
			assert_equal(4, result[0])
		end
		
		should "multiply multiple numbers" do
			result = @interpreter.run("(* 2 3 4)")
			assert_equal(24, result[0])
		end
		
		should "multiply defined variables" do
			result = @interpreter.run(
			"(define a 4)
			 (define b 2)
			 (* a b)")
			assert_equal(8, result[0])
		end
	end
end
