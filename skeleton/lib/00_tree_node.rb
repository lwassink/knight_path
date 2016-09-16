class PolyTreeNode
  attr_reader :value
  attr_reader :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    @parent.children.delete(self) unless @parent.nil?
    node.children << self unless node.nil?

    @parent = node
  end

  def children
    @children
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    if @children.include?(node)
      node.parent = nil
    else
      raise "This node is not a child"
    end
  end

  def dfs(target_value)
    return self if self.value == target_value

    @children.each do |child|
      search_result = child.dfs(target_value)
      return search_result if search_result
    end

    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      root = queue.shift
      return root if root.value == target_value
      queue += root.children
    end
    nil
  end
end
