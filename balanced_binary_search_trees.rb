# frozen_string_literal: true

# This class represents a node in a balanced binary search tree.
class Node
  attr_accessor :data, :left, :right

  @data
  @left
  @right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

# This class represents a balanced binary search tree.
class Tree
  attr_reader :root

  @root

  def initialize(arr)
    build_tree(arr)
  end

  def build_tree(arr)
    arr = arr.uniq.sort
    middle = get_middle_index(arr)

    @root = Node.new(arr[middle])
    if middle < arr.length - 1
      right_arr = arr[middle + 1..]
      @root.right = Tree.new(right_arr).root
    end
    if middle.positive?
      left_arr = arr[0..middle - 1]
      @root.left = Tree.new(left_arr).root
    end
    @root
  end

  def get_middle_index(arr)
    (arr.length - 1) / 2
  end

  def insert(value, node = @root)
    new_node = Node.new(value)
    if value > node.data
      node.right.nil? ? node.right = new_node : insert(value, node.right)
    end
    return unless value < node.data

    node.left.nil? ? node.left = new_node : insert(value, node.left)
  end

  def delete(value)
    new_arr = inorder
    new_arr.delete(value)
    build_tree(new_arr)
  end

  def find(value, node = @root)
    if node.data == value
      node
    elsif value > node.data
      node.right.nil? ? nil : find(value, node.right)
    else
      node.left.nil? ? nil : find(value, node.left)
    end
  end

  def level_order(node = @root, queue = [], &block)
    arr = [node.data]
    queue.push(node.left) unless node.left.nil?
    queue.push(node.right) unless node.right.nil?
    arr += level_order(queue[0], queue[1..]) unless queue.empty?
    if block_given?
      arr.each(&block)
    else
      arr
    end
  end

  def inorder(node = @root, &block)
    arr = [node.data]
    arr = inorder(node.left) + arr unless node.left.nil?
    arr += inorder(node.right) unless node.right.nil?
    if block_given?
      arr.each(&block)
    else
      arr
    end
  end

  def preorder(node = @root, &block)
    arr = [node.data]
    arr += preorder(node.left) unless node.left.nil?
    arr += preorder(node.right) unless node.right.nil?
    if block_given?
      arr.each(&block)
    else
      arr
    end
  end

  def postorder(node = @root, &block)
    arr = []
    arr = postorder(node.left) unless node.left.nil?
    arr += postorder(node.right) unless node.right.nil?
    arr += [node.data]
    if block_given?
      arr.each(&block)
    else
      arr
    end
  end

  def height(value)
    return if find(value).nil?

    # return the height of the node containing this value
    0
  end

  def depth(value, depth = 0, node = @root)
    return if find(value).nil?

    if value == node.data
      depth
    elsif value > node.data
      depth(value, depth + 1, node.right)
    else
      depth(value, depth + 1, node.left)
    end
  end

  def balanced?
    # check if tree is balanced
  end

  def rebalance
    # rebalances the tree
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# example_arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
example_arr = [1, 2, 3, 4, 5, 6, 7]

example_tree = Tree.new(example_arr)

example_tree.pretty_print
# pp(example_tree.preorder { |x| p(x * 2) })
pp (example_tree.level_order  { |x| p(x * 2) })
# example_tree.pretty_print
