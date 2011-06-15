require 'helper'

module Theta
	class TestParser < Test::Unit::TestCase
		def setup
			@parser = Parser.new
		end
		
		context "atom" do
			should "convert string to symbol" do
				result = @parser.atom("test")
				assert_equal(:test, result)
			end
			
			should "leave numbers alone" do
				result = @parser.atom("1")
				assert_equal(1, result)
			end
		end
		
		context "tokenize" do
			should "split a statement apart into its component pieces" do
				result = @parser.tokenize("(define a 1)")
				assert_equal(["(", "define", "a", "1", ")"], result)
			end
			
			should "be able to handle multiple statements at a time" do	
				result = @parser.tokenize("(define a 1) (define b 2)")
				assert_equal(["(", "define", "a", "1", ")","(", "define", "b", "2", ")"], result)
			end
		end
		
		context "read_from" do
			should "turn a tokenized statement into an interpreter understandable array" do
				result = @parser.read_from(["(", "define", "a", "1", ")"])
				assert_equal([[:define, :a, 1]], result)
			end
			
			should "be able to handle multiple statements at a time" do
				tokens = @parser.tokenize("(define a 1) (define b 2)")
				result = @parser.read_from(tokens)
				assert_equal([[:define, :a, 1], [:define, :b, 2]], result)
			end
			
			should "be able to handle nested expressions" do
				tokens = @parser.tokenize("(+ 2 (+ 3 5))")
				result = @parser.read_from(tokens)
				assert_equal([[:+, 2, [:+, 3, 5]]], result)
			end
		end
		
		context "to_string" do
			should "turn a parsed statement back into a human readable format" do
				result = @parser.to_string([:define, :a, 1])
				assert_equal("(define a 1)", result)
			end
		end
	end
end
