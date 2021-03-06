def out_string( test_no, answer )
	"Case ##{test_no.to_s}: #{answer}"
end

def target_chars( words, index, prev )
	if prev.empty?
		return words.map { |w| w[index] }.uniq
	else
		chars = []
		words.map { |w| w[index] }.uniq.each do |c|
			prev.each do |p|
				chars << c + p 
			end
		end
		return chars.uniq
	end
end

def valid_word?( word, words )
	not words.include? word
end

def solve(test_no, numwords, length, words)
	
	#early exits
	if ( length == 1 || numwords == 1)
		return out_string(test_no, '-')
	end
	
	target_chars = []
		
	counter = length - 1
	while counter > 0
		target_chars = target_chars(words, counter, target_chars)
		
		words.each do |w|
			#puts "Solving case ##{test_no}, counter is #{counter}, word is #{w}, targets are #{target_chars.to_s}" 
			target_chars.each do |c|
				str = w.slice(0...counter) + c
				if valid_word?( str, words)
					return out_string(test_no, str)
				end
			end
		end
		
		counter = counter - 1
	end
	
	return out_string(test_no, '-')
end

case_number = 1;
t = STDIN.gets.chomp.to_i
while case_number <= t
	numwords, length = STDIN.gets.chomp.split.map &:to_i
	words = []
	numwords.times { words << STDIN.gets.chomp }
	puts solve( case_number, numwords, length, words ) 
	case_number += 1
end