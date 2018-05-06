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




test_no = 3
words = ['AA', 'AB', 'BA', 'BB']
words.each do |w|
target_chars = []
	counter = w.length - 1
	while counter > 0
		target_chars = target_chars(words, counter, target_chars)
		if (test_no ==3)
			puts "counter is: " + counter.to_s + " , word is: " + w + ", target chars are: "
		end
p target_chars
		target_chars.each do |c|
			str = w.slice(0..(counter-1)) + c
			if valid_word?( str, words)
				puts out_string(test_no, str)
			end
		end

		counter = counter - 1

	end
end
puts out_string(test_no, '-')
