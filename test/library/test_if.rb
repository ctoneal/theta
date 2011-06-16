require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper.rb"))

module Theta
	class TestIf < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end
		
		context "without else" do
			should "execute statement if true" do
				@interpreter.run("
					(if #t
						(define a 1))
				")
				assert_equal(1, @interpreter.current_environment.find(:a))
			end
			
			should "not execute statement if false" do
				@interpreter.run("
					(if #f
						(define a 1))
				")
				assert_equal(nil, @interpreter.current_environment.find(:a))
			end
		end
		
		context "with else" do
			should "execute else statement if false" do
				@interpreter.run("
					(if #f
						(define a 1)
						(define b 1))
				")
				assert_equal(nil, @interpreter.current_environment.find(:a))
				assert_equal(1, @interpreter.current_environment.find(:b))
			end
			
			should "not execute else statement if true" do
				@interpreter.run("
					(if #t
						(define a 1)
						(define b 1))
				")
				assert_equal(1, @interpreter.current_environment.find(:a))
				assert_equal(nil, @interpreter.current_environment.find(:b))
			end
		end
	end
end
