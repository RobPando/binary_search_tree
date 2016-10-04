class Node 
	attr_accessor :value, :parent_node, :left_child, :right_child

	def initialize(value, parent_node = nil)
		@value = value
		@parent_node = parent_node
	end
end

class BuildTree
	attr_reader :root

	def initialize(values)
		@root = Node.new(values[0])
		build_tree(values[1..-1])
		location(@root)
	end

	def build_tree(values)
		values.each { |obj| to_tree(@root, obj) }
	end

	def to_tree(root, node)
		if root.value > node
			if root.left_child.nil?
				root.left_child = Node.new(node, root)
			else
				to_tree(root.left_child, node)
			end
		else
			if root.right_child.nil?
				root.right_child = Node.new(node, root)
			else
				to_tree(root.right_child, node)
			end
		end
	end				

	def location(root)
		puts "You are in the root: #{root.value}" 
		print "Left child is: #{root.left_child.value} " unless root.left_child.nil?
		print "Right child is: #{root.right_child.value}" unless root.right_child.nil?
		print "LEAF NODE" if root.left_child.nil? && root.right_child.nil?
		print "\nGo to [p]arent node? or [l]eft child? " if root.right_child.nil?
		print "\nGo to [p]arent node? or [l/r] child? " unless root.right_child.nil?
		puts "OR"
		puts "Type 'bfs' for breadth first search "
		puts "Type 'dfs' for depth first search "
		puts "Type 'dfsr' for recursive dfs "
		print ">> "
		answer = gets.strip
		options = ['bfs', 'dfs', 'dfsr']
		search_type(answer) if options.include?(answer)
		to_parent(root) if answer == 'p'
		to_child(root, answer) if (answer == 'l' && !root.left_child.nil?) || (answer == 'r' && !root.right_child.nil?)
	end

	def to_parent(node)
		if node.parent_node.nil?
			puts "Nil parent node."
		else
			node = node.parent_node
		end
		location(node)
	end

	def to_child(node, direction)
		case direction
		when 'r'
			node = node.right_child
		when 'l'
			node = node.left_child
		end
		location(node)
	end

	def search_type(answer)
		print "Type the value you are looking for: "
		target = Integer(gets)
		case answer
		when 'bfs'
			breadth_first_search(target)
		when 'dfs'
			depth_first_search(target)
		when 'dfsr'
			resp = dfs_rec(@root, target)
			puts "NODE NOT FOUND!" if resp.nil?
			puts "#{resp.value} FOUND!: #{resp}" if resp.value == target
		end
	end

	def breadth_first_search(target)
		found = false
		queue = [@root]
		begin
			current_root = queue.shift
			queue << current_root.left_child unless current_root.left_child.nil?
			queue << current_root.right_child unless current_root.right_child.nil?

			if current_root.value == target
				found = true
				break
			end
		end until queue.empty?
		if found == true
			puts "Node value: #{current_root.value} found!: #{current_root}"
		else
			puts "#{target} NOT FOUND"
		end
	end

	def depth_first_search(target)
		stack_call = [@root]
		found = false
		current_root = @root
		begin
			if current_root.value == target
				found = true
				break
			elsif current_root.left_child.nil?
				current_root = stack_call.shift.right_child
			else
				current_root = current_root.left_child
			end
			unless current_root.right_child.nil?
				stack_call << current_root
			end
		end until current_root.nil?
		if found == true
			puts "#{current_root.value} FOUND!: #{current_root}"
		else
			puts "NODE NOT FOUND!"
		end
	end

	def dfs_rec(target, value)
		return target if target == nil
		dfs_rec(target.left_child, value)
		return target if target.value == value
		dfs_rec(target.right_child, value)
	end

end

node_tree = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

print "Building the tree of the following array: "
print node_tree.join(", ")
puts "\n..."

tree = BuildTree.new(node_tree)




