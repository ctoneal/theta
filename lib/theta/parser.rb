module Theta
	# parses strings into arrays of items understandable by the interpreter
	class Parser

		# returns the scheme interpretation of the string
		def parse(string)
			return read_from(tokenize(string))
		end
	
		# converts a string into an array of tokens
		def tokenize(string)
			return string.gsub("(", " ( ").gsub(")", " ) ").split
		end

		# reads an expression from an array of tokens (created
		# by tokenize)
		def read_from(tokens)
			if tokens.length == 0
				raise SyntaxError, "unexpected EOF while reading"
			end
			token = tokens.shift
			if "(" == token
				l = []
				until tokens[0] == ")"
					l << read_from(tokens)
				end
				tokens.shift
				return l
			elsif ")" == token
				raise SyntaxError, "unexpected )"
			elsif "\"" == token
				string = ""
				until tokens[0] == "\""
					string += " " + tokens.shift
				end
				tokens.shift
				return string.gsub(/\n/, "")
			else
				return atom(token)
			end
		end

		# returns appropriate numeric object if a number, 
		# otherwise returns a symbol
		def atom(token)
			begin
				return Integer(token)
			rescue ArgumentError
				begin
					return Float(token)
				rescue ArgumentError
					return token.to_sym
				end
			end
		end

		# convert an expression back to a readable string
		def to_string(expression)
			if expression.is_a? Array
				return "(" + " ".join(expression.map { |exp| to_string(exp) }) + ")"
			else
				return expression.to_s
			end
		end
	end
end
