require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper.rb"))

module Theta
	class TestAdd < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end
		
		should "add numbers correctly" do
			result = @interpreter.run("(+ 2 2)")
			assert_equal(4, result)
		end
		
		should "add a series of numbers" do
			result = @interpreter.run("(+ 5 4 3 2 1)")
			assert_equal(15, result)
		end
		
		should "add defined variables" do
			@interpreter.run("(define a 1)")
			@interpreter.run("(define b 2)")
			result = @interpreter.run("(+ a b)")
			assert_equal(3, result)
		end
	end
end
