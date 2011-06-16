require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper.rb"))

module Theta
	class TestLessThan < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end
		
		should "return true if first arg is smallest" do
			result = @interpreter.run("(< 1 2 3)")
			assert_equal(true, result[0])
		end
		
		should "return false if first arg isn't smallest" do
			result = @interpreter.run("(< 5 2 10)")
			assert_equal(false, result[0])
		end
		
		should "work with variables" do
			@interpreter.run("
				(define a 1)
				(define b 2)
				(define c 3)
			")
			result = @interpreter.run("
				(< a b c)
				(< b a c)
			")
			assert_equal(true, result[0])
			assert_equal(false, result[1])
		end
	end
end
