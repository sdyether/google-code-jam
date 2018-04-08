def calc_damage( program_string )
	damage = 0
	charges = 0
	program_string.each_char do |char|
		if (char == 'C')
			charges += 1
		else
			damage = damage + 2**charges
		end
	end
	
	damage
end

def solved?( program_string, damage )
	calc_damage( program_string ) <= damage
end

def out_string( test_no, answer )
	"Case ##{test_no}: #{answer}"
end

def solve_for_line(line, test_no)
	damage = line.split[0].to_i
	program = line.split[1]

	#edge cases exit early
	if (solved?( program, damage ))
		return out_string(test_no, '0')
	end
	
	if (program.count('S') > damage)
		return out_string(test_no, 'IMPOSSIBLE')
	end
	
	#solve
	swap_count = 0;
	until not program.include?('CS') or solved?(program, damage) do
		program = program.reverse.sub('CS'.reverse, 'SC'.reverse).reverse #optimal swap
		swap_count += 1
	end
	
	if solved?(program, damage)
		return out_string(test_no, swap_count)
	end
	
	return out_string(test_no, 'IMPOSSIBLE') 
end

ARGF.each_with_index do |line, idx|
	if idx == 0
		next
	end
	puts solve_for_line( line, idx.to_s ) 
end
