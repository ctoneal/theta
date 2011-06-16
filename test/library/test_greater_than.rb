require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper.rb"))

module Theta
	class TestGreaterThan < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end
		
		should "return true if first arg is largest" do
			result = @interpreter.run("(> 5 1 2 3)")
			assert_equal(true, result[0])
		end
		
		should "return false if first arg isn't largest" do
			result = @interpreter.run("(> 5 1 2 10)")
			assert_equal(false, result[0])
		end
		
		should "work with variables" do
			@interpreter.run("
				(define a 1)
				(define b 2)
				(define c 3)
			")
			result = @interpreter.run("
				(> c b a)
				(> b a c)
			")
			assert_equal(true, result[0])
			assert_equal(false, result[1])
		end
	end
end
