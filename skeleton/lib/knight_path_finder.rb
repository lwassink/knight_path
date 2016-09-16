require_relative '00_tree_node'

class KnightPathFinder
  attr_reader :starting_position, :visited_positions

  def initialize(starting_position)
    @starting_position = starting_position
    @visited_positions = [@starting_position]
  end

  def self.valid_moves(pos)
    x,  y = pos
    translations = [[2,1], [2,-1], [1, 2], [1, -2], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]

    moves = translations.map do |translation|
      x_trans, y_trans = translation
      [x + x_trans, y + y_trans]
    end

    moves.select do |move|
      x, y = move
      x.between?(0, 7) & y.between?(0, 7)
    end
  end

  def new_moves(pos)
    new_moves = self.class.valid_moves(pos) - @visited_positions
    @visited_positions += new_moves
    new_moves
  end

  def build_move_tree
    @visited_positions = [@starting_position]
    start = PolyTreeNode.new(@starting_position)
    queue = [start]

    until queue.empty?
      root = queue.shift

      new_moves(root.value).each do |move|
        move_node = PolyTreeNode.new(move)
        move_node.parent = root
        queue << move_node
      end
    end
    start
  end

  def find_path(end_pos)
    end_node = build_move_tree.bfs(end_pos)
    end_node.path_to_root.map(&:value)
  end

  def inspect
    p @starting_position
  end
end
