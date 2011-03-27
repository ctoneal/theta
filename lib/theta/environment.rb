module Theta
	class Environment
		def initialize(parent = nil)
			@parent = parent
			@table = {}
			if @parent.nil?
				define(":#t", true)
				define(":#f", false)
			end
		end

		def find(name)
			if @table.has_key?(name)
				return @table[name]
			elsif @parent.nil?
				return nil
			else
				@parent.find(name)
			end
		end

		def define(name, value)
			@table[name] = value
		end
	end
end
