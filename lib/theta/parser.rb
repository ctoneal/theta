module Theta
	# parses strings into arrays of items understandable by the interpreter
	class Parser

		# returns the scheme interpretation of the string
		def parse(string)
			return read_from(tokenize(string))
		end
	
		# converts a string into an array of tokens
		def tokenize(string)
			tokens = []
			found_string = false
			temp = ""
			# loop through each character passed
			string.each_char do |char|
				# if we're currently in a string and we hit the quote,
				# it's the end of the string.
				# move the string into the token array
				if found_string
					if char == "\""
						found_string = false
						temp << char
						if not temp.empty?
							tokens << temp
						end
						temp = ""
					# otherwise add the character to the temporary variable
					else
						temp << char
					end
				else
					# if we hit parentheses, add whatever's in temp as a token
					# then add the parentheses as a token
					if char == "(" || char == ")"
						if not temp.empty?
							tokens << temp
							temp = ""
						end
						tokens << char
						next
					# if we hit a quote, we're beginning a string
					# flip the found_string flag and begin adding to the temp variable
					elsif char == "\""
						found_string = true
						temp << char
					# space signals the end of a token, push the temp variable on the token queue
					elsif char == " "
						if not temp.empty?
							tokens << temp
						end
						temp = ""
					# ignore tabs or newlines, unless there's something in temp
					# push that onto tokens
					elsif char == "\t" || char == "\n"
						if not temp.empty?						
							tokens << temp
						end
						temp = ""
					# add the character to temp to build a token
					else
						temp << char
					end
				end
			end
			return tokens
		end

		# reads an expression from an array of tokens (created
		# by tokenize)
		def read_from(tokens)
			if tokens.length == 0
				raise SyntaxError, "unexpected EOF while reading"
			end
			tokens.delete_if { |item| item.strip == "" || item == []}
			tmp, expression = restructure tokens
			return expression
		end	
			
		def restructure(token_array, offset = 0)
			statement = []
			while offset < token_array.length
				if token_array[offset] == "("
					offset, tmp_array = restructure(token_array, offset + 1)
					statement << tmp_array
				elsif token_array[offset] == ")"
					break
				else
					statement << atom(token_array[offset])
				end
				offset += 1
			end
			return offset, statement
		end
			
#			token = tokens.shift
#			if "(" == token
#				l = []
#				until tokens[0] == ")"
#					l << read_from(tokens)
#				end
#				tokens.shift
#				return l
#			elsif ")" == token
#				raise SyntaxError, "unexpected )"
#			elsif token.start_with?("\"")
#				return token.gsub("\"", "")
#			else
#				return atom(token)
#			end
#		end

		# returns appropriate numeric object if a number, 
		# otherwise returns a symbol
		def atom(token)
			if token.start_with?("\"")
				return token.gsub("\"", "")
			end
			token.gsub!(/\n\t/, "")
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
				expression.map { |exp| to_string(exp) }
				return "(" + expression.join(" ") + ")"
			else
				return expression.to_s
			end
		end
	end
end
