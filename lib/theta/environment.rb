module Theta
	# An environment, stores defined items for a
	# particular level
	class Environment
	
		attr_accessor :parent
		
		def initialize(parent = nil)
			@parent = parent
			@table = {}
			if @parent.nil?
				define("#t".to_sym, true)
				define("#f".to_sym, false)
			end
		end

		# find an item in the environment
		def find(name)
			if @table.has_key?(name)
				return @table[name]
			elsif @parent.nil?
				return nil
			else
				@parent.find(name)
			end
		end

		# define an item in the environment
		def define(name, value)
			@table[name] = value
		end
	end
end
