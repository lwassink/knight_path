require_relative '00_tree_node'

class KnightPathFinder
  attr_reader :starting_position

  def initialize(starting_position)
    @starting_position = PolyTreeNode.new(starting_position)
    @visited_positions = [@starting_position]
  end

  def self.valid_moves(node)
    x,  y = node.value
    translations = [[2,1], [2,-1], [1, 2], [1, -2], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]

    moves = translations.map do |translation|
      x_trans, y_trans = translation
      PolyTreeNode.new([x + x_trans, y + y_trans])
    end

    moves.select do |move|
      x, y = move.value
      x.between?(0, 7) & y.between?(0, 7)
    end
  end

  def inspect
    p @starting_position.value
  end

end
