class BST

  attr_reader :root

  def initialize
    @root = nil
  end

  # This class contains the value of 
  # the key and links to its parents
  # and children if they exist.
  class Node

    attr_accessor :left_child, :right_child
    attr_reader :value

    def initialize(value)
      @value = value
      @left_child = nil
      @right_child = nil
    end
  end

  def insert(element)
    tree = @root
    loop do
      if element <= tree.value && tree.left_child.nil? 
        tree.left_child = Node.new(element)
        break
      elsif element <= tree.value && !tree.left_child.nil?
        tree = tree.left_child
      elsif element > tree.value && tree.right_child.nil?
        tree.right_child = Node.new(element)
        break
      else
        tree = tree.right_child
      end
    end
  end

  def build_tree(array)
    return puts "Empty Array" if array.empty?
    @root = Node.new(array.first)
    1.upto(array.size - 1) { |index| insert(array[index]) } if array.size > 1
    return @root
  end

  def breadth_first_search(value)
    return puts "The tree is empty" if @root.nil?
    array = []
    array.push(@root)
    until array.empty?
      node = array.shift
      return node if node.value == value
      array.push(node.left_child) unless node.left_child.nil?
      array.push(node.right_child) unless node.right_child.nil?
    end
    return nil
  end

  def depth_first_search(value)
    return puts "The tree is empty" if @root.nil?
    array = []
    array.push(@root)
    until array.empty?
      if array.last.left_child.nil?
        begin
          node = array.pop
          return node if node.value == value
        end while node.right_child.nil? && !array.empty?
        array.push(node.right_child) unless node.right_child.nil?
      else
        array.push(array.last.left_child)
      end
    end
    return nil
  end

  def dfs_rec(value, node)
    found_left = dfs_rec(value, node.left_child) unless node.left_child.nil?
    return found_left unless found_left.nil?

    return node if node.value == value

    found_right = dfs_rec(value, node.right_child) unless node.right_child.nil?
    return found_right
  end
end