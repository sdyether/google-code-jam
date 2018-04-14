def out_string( test_no, answer )
	"Case ##{test_no.to_s}: #{answer}"
end

def can_partition?( partition_size, num_partitions, arr )
	#puts "called with #{partition_size.to_s}, #{num_partitions.to_s}, #{arr}"
	sum = 0
	partition_count = 0
	arr.each do |a|
		sum += a
		if (sum > partition_size)
			return false
		end
		
		if (sum == partition_size)
			sum = 0
			partition_count += 1
		end
	end
	return num_partitions == partition_count
end

def solve(test_no, rows, cols, hcuts, vcuts, arr)
	
	num_chips = 0
	arr.each { |r| num_chips += r.reduce(:+) }
	diners = (hcuts + 1) * (vcuts + 1)
	
	#early exits
	if ( num_chips == 0 )
		return out_string(test_no, 'POSSIBLE')
	end
	
	if ( num_chips % diners != 0 )
		return out_string(test_no, 'IMPOSSIBLE')
	end
	
	pieces = num_chips / diners

	hchips = arr.each.map { |r| r.reduce(:+) }
	vchips = arr.transpose.each.map { |r| r.reduce(:+) }
	
	#vertical case
	if not can_partition? (num_chips / (vcuts + 1)), (vcuts + 1), vchips
		return out_string(test_no, 'IMPOSSIBLE')
	end
	
	#horizontal case
	if not can_partition? (num_chips / (hcuts + 1)), (hcuts + 1), hchips
		return out_string(test_no, 'IMPOSSIBLE')
	end
	
	return out_string(test_no, 'POSSIBLE')
end

case_number = 1;
t = STDIN.gets.chomp.to_i
while case_number <= t
	rows, cols, hcuts, vcuts = STDIN.gets.chomp.split.map &:to_i
	arr = []
	rows.times { arr << STDIN.gets.chomp.chars.map { |c| c == '@' ? 1 : 0 } }
	puts solve( case_number, rows, cols, hcuts, vcuts, arr ) 
	case_number += 1
end