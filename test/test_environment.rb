require 'helper'

module Theta
	class TestEnvironment < Test::Unit::TestCase
		def setup
			@environment = Environment.new
		end
		
		context "new" do
			should "add definition for true" do
				result = @environment.find("#t".to_sym)
				assert_equal(true, result)
			end
			
			should "add definition for false" do
				result = @environment.find("#f".to_sym)
				assert_equal(false, result)
			end
		end
		
		context "find" do
			should "return nil for undefined item" do
				result = @environment.find(:a)
				assert_equal(nil, result)
			end
			
			should "return defined item" do
				@environment.define(:a, 1)
				result = @environment.find(:a)
				assert_equal(1, result)
			end
			
			should "return item defined in parent" do
				@environment.define(:a, 1)
				child = Environment.new(@environment)
				result = child.find(:a)
				assert_equal(1, result)
			end
			
			should "override a variable in parent if defined in current" do
				@environment.define(:a, 1)
				child = Environment.new(@environment)
				child.define(:a, 3)
				result = child.find(:a)
				assert_equal(3, result)
			end
		end
	end
end
