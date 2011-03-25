#require File.expand_path(File.join(File.dirname(__FILE__), "theta", ""))

module Theta
	class Base
	
		def initialize
			@globalEnvironment = Environment.new
		end
		
		def run
		end	
		
		def repl
		end
	end
end