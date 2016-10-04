class Node
	attr_accessor :position, :parent

	def initialize(position, parent=nil)
		@position = position
		@parent = parent
	end
end

class Knight
	attr_reader :current

	def initialize(spot)
		@spot = spot
		knight_place(@spot)
	end


	def possible_moves(position)
		directions = [[-1, 1],[-2, 2]] #2 pairs of numbers that make up the combinations of the way knight moves.
		moves = []
		possible_ones = []
		directions[0].each { |i| directions[1].each{|j| moves << [position[0]+i,position[1]+j] }} #Generates the first 4 combinations
		directions[1].each { |j| directions[0].each{|i| moves << [position[0]+j,position[1]+i] }} #Generates the remaining 4 combination
		moves.each { |x| possible_ones << x unless (x[0] < 0 || x[1] < 0) || (x[0] > 7 || x[1] > 7) } #Discards the moves that go off the board.
		return possible_ones
	end

	def walk_this_way(root, destination) #Breadth first search method
		current = Node.new(root)
		queue = [current]
		path = []
		found = false
		begin
			current_child = possible_moves(current.position)
			current_child.each{ |x| queue << Node.new(x, current) }
			current = queue.shift

			if current.position == destination
				path << current.position
				#Adds up the chain to obtain the full path
				until current.parent.nil? 
				path << current.parent.position
				current = current.parent
				end
				path.reverse! #Reverses the array to show root as first one and destination as last one.
 				found = true
			end

		end until found == true
		return path 
	end

private
	def knight_place(current)
		7.downto(0) { |i| 
			puts "\n\n"
			0.upto(7) { |j| print "[#{i},#{j}]" unless i == current[0] && j == current[1]
											print "[ ♘ ]" if i == current[0] && j == current[1] } }
			puts ""
	end

end

knight = [3, 4]
knight_dance = Knight.new(knight)
move = knight_dance.walk_this_way([0,0], [5,3])
print move
puts ""