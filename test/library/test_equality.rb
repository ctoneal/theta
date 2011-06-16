require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper.rb"))

module Theta
	class TestEquality < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end
		
		should "return true for correct expressions" do
			result = @interpreter.run("(= 2 2)")
			assert_equal(true, result[0])
		end
		
		should "return false for incorrect expressions" do
			result = @interpreter.run("(= 2 3)")
			assert_equal(false, result[0])
		end
		
		should "work with multiple arguments" do
			result = @interpreter.run("
				(= 2 2 2)
				(= 2 2 3 2)
			")
			assert_equal(true, result[0])
			assert_equal(false, result[1])
		end
		
		should "work with variables" do
			@interpreter.run("
				(define a 1)
				(define b 2)
			")
			result = @interpreter.run("
				(= a a)
				(= a b)
			")
			assert_equal(true, result[0])
			assert_equal(false, result[1])
		end
	end
end
