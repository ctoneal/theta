require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper.rb"))

module Theta
	class TestMultiply < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end
		
		should "multiply numbers properly" do
			result = @interpreter.run("(* 2 2)")
			assert_equal(4, result)
		end
		
		should "multiply multiple numbers" do
			result = @interpreter.run("(* 2 3 4)")
			assert_equal(24, result)
		end
		
		should "multiply defined variables" do
			@interpreter.run("(define a 3)")
			@interpreter.run("(define b 2)")
			result = @interpreter.run("(* a b)")
			assert_equal(6, result)
		end
	end
end
