
def populate_2d_matrix( rows, cols )
	coords = []
	rows.each do |x|
		cols.each do |y|
			coords << [x, y]
		end
	end
	coords
end

#return the shape closest to a square
def get_dimensions( area )
	x = Math.sqrt( area ).floor
	loop do
		break if (area % x == 0)
		x -= 1
	end
	return x, (area / x)
end

#send a requested square to the judge and return the chosen square
def request_square( target_x, target_y )
	puts "#{target_x.to_s} #{target_y.to_s}"
	$stdout.flush
	return STDIN.gets.split.map &:to_i;
end

def solve_interactive_test( area )

	height, width = get_dimensions( area )
	x, y = request_square( 4, 4 ) #anywhere near the edge to begin
	
	#use the first gopher coord as the corner of our target rect for performance
	target_squares = populate_2d_matrix( (x + 1 ... x + width - 1), (y + 1 ... y + height - 1) )
	
	#main data structure is a hash, where 
	#K = a square [x,y] and 
	#V = a list (0 <= size <= 9) of surrounding squares that are not prepared 
	lists = {}
	target_squares.each do |x, y|
		lists[[x, y]] = populate_2d_matrix( [x - 1, x, x + 1], [y - 1, y, y + 1] )
	end	
	
	loop do
		#choose the square with the highest weighting
		target_x, target_y = lists.key( lists.values.max_by &:size )
		x, y = request_square( target_x, target_y )

		#update all lists that could contain the dug square
		populate_2d_matrix( (x - 2 ... x + 2), (y - 2 ... y + 2) ).each do |square|
			l = lists[square]
			if not l.nil?
				l.delete [x, y] 
			end
		end

		break if (x == 0)
		if (x == -1)
			exit 1
		end
	end 
end

$stdout.sync = true
case_number = 1;
t = STDIN.gets.chomp.to_i
while case_number <= t
	area = STDIN.gets.chomp.to_i
	solve_interactive_test( area ) 
	case_number += 1
end
