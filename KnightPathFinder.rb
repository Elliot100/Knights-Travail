require_relative "PolyTreeNode.rb"
require_relative "Queue.rb"
require "byebug"

class KnightPathFinder
    attr_accessor :considered_pos
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
        true
    end

    def build_tree  
        
        @new_queue.queue << @tree
        until @new_queue.queue.empty?
            current_node = @new_queue.dequeue
            @considered_pos << current_node.value unless @considered_pos.include?(current_node.value)
            next_moves = get_next_moves(current_node)
            next_moves.each do |next_move| 
                @considered_pos << next_move unless @considered_pos.include?(next_move)
                child = PolyTreeNode.new(next_move)
                child.parent = current_node
                @new_queue.queue << child
            end
            # if current_node.value == [5,0] 
            #     current_node.children.each {|kid| p kid.value}
            # end
        end
        true
    end

    def get_next_moves(node)
        all_posible_moves = get_all_possible_moves(node.value)
        all_posible_moves = all_posible_moves.select {|move| KnightPathFinder.valid_move?(move) }
        all_posible_moves.select { |move| !@considered_pos.include?(move) }

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

    def find_path(pos)
        new_queue = Queue.new
        new_queue.enqueue(@tree)
        until new_queue.queue.empty?
            current_node = new_queue.dequeue
            current_node.children.each do |child|
                if child.value == pos
                    return trace_path_back(child)
                end
                new_queue.queue << child
            end
        end
    end

    def trace_path_back(finish_node)
        shortest_path = []
        current_node = finish_node

        until current_node == nil # parent is nil if root
            shortest_path.unshift(current_node.value)
            current_node = current_node.parent
        end
        shortest_path
    end
end