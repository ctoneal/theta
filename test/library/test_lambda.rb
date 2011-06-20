require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper.rb"))

module Theta
	class TestLambda < Test::Unit::TestCase
		def setup
			@interpreter = Interpreter.new
		end
		
		should "create a function" do
			result = @interpreter.run("
				(lambda () ())
			")
			assert_kind_of(Proc, result[0])
		end

		should "accept an argument" do
			result = @interpreter.run("
				(define test (lambda (a) (+ a a)))
				(test 1)
			")
			assert_equal(2, result[0])
		end
		
		should "accept multiple arguments" do
			result = @interpreter.run("
				(define test (lambda (a b c) (+ a b c)))
				(test 1 2 3)
			")
			assert_equal(6, result[0])
		end
		
		should "raise an error if a param is used more than once" do
			assert_raise(RuntimeError) {
				@interpreter.run("
					(lambda (a a) (+ a 2))
				")
			}
		end
	end
end
