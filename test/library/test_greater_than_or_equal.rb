require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper.rb"))

module Theta
	class TestGreaterThanOrEqual < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end
		
		should "return true if first arg is largest" do
			result = @interpreter.run("(>= 4 3 2)")
			assert_equal(true, result[0])
		end
		
		should "return true if first arg is equal to the largest" do
			result = @interpreter.run("(>= 4 3 2 4)")
			assert_equal(true, result[0])
		end
		
		should "return false if first arg is not greater than or equal to the largest" do
			result = @interpreter.run("(>= 4 3 2 10)")
			assert_equal(false, result[0])
		end
		
		should "work with variables" do
			@interpreter.run("
				(define a 1)
				(define b 2)
				(define c 3)
			")
			result = @interpreter.run("
				(>= c b a)
				(>= c b a c)
				(>= b c a)
			")
			assert_equal(true, result[0])
			assert_equal(true, result[1])
			assert_equal(false, result[2])
		end
	end
end
