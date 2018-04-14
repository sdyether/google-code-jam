
def out_string( test_no, answer )
	"Case ##{test_no.to_s}: #{answer}"
end

def solve_for_line(line, test_no)
	arr = line.split.map(&:to_i)
	#uncomb and sort seperately
	arr1 = arr.values_at(*arr.each_index.select(&:even?))
	arr2 = arr.values_at(*arr.each_index.select(&:odd?))
	arr = arr1.sort.zip(arr2.sort).flatten.compact #merge back together, noting arr1.size can be 1 greater than arr2.size

	arr.each_cons(2).to_a.each_with_index do |(curr, nekst), idx|
		if curr > nekst
			return out_string(test_no, idx.to_s)
		end
	end
	
	return out_string(test_no, 'OK') 
end

case_number = 1;
ARGF.each_with_index do |line, idx|

	if idx == 0 or idx % 2 == 1
		next
	end

	puts solve_for_line( line, case_number ) 
	case_number += 1
end
