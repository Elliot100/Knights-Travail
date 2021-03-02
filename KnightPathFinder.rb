require_relative "PolyTreeNode.rb"
require_relative "Queue.rb"
require "byebug"

class KnightPathFinder

    def self.valid_move?(pos)
        row,col = pos
        if row>-1 && col>-1 && row<8 && col<8  #check if within the board
            return true
        end
        false
    end

    def initialize(start_pos)
        @start_pos = start_pos
        @tree = PolyTreeNode.new(start_pos)
        @new_queue = Queue.new
        @considered_pos = []
        build_tree
    end

    def build_tree  
        
        @new_queue.queue << @tree
        until @new_queue.queue.empty?
            debugger
            current_node = @new_queue.dequeue
            @considered_pos << current_node.value
            next_moves = get_next_moves(current_node)
            next_moves.each do |next_move| 
                child = PolyTreeNode.new(next_move)
                child.parent = current_node
                @new_queue.queue << child
            end
        end
    end

    def get_next_moves(node)
        all_posible_moves = get_all_possible_moves(node.value)
        all_posible_moves = all_posible_moves.select {|move| KnightPathFinder.valid_move?(move) }
        all_posible_moves.select {|move| !@considered_pos.include?(move) }

    end

    def get_all_possible_moves(pos)
        all_moves = []
        row,col = pos
        all_moves << [row-1,col-2]
        all_moves << [row-1,col+2]
        all_moves << [row-2,col+1]
        all_moves << [row+2,col+1]
        all_moves << [row+1,col-2]
        all_moves << [row+1,col+2]
        all_moves << [row-2,col-1]
        all_moves << [row+2,col-1]
        all_moves
    end 

    def inspect
        @value
    end
end