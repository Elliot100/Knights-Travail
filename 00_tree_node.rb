require_relative "Queue.rb"

class PolyTreeNode
    attr_accessor :parent, :children, :value
    def initialize(val)
        @parent = nil
        @children = []
        @value = val
    end

    def parent
        @parent
    end

    def children
        @children
    end

    def value
        @value
    end

    def parent=(another_node)
        old_parent = @parent
        if old_parent != nil
            old_parent.children.each_with_index do |node,i|  #remove self node from parent
                old_parent.children = old_parent.children.take(i) + old_parent.children.drop(i+1) if node == self
            end
        end

        @parent = another_node
        another_node.children << self unless another_node.children.include?(self) unless @parent.nil? == true
    end

    def add_child(child)
        child.parent = self
        self.children << child unless self.children.include?(child)
    end

    def remove_child(child)
        childrens = self.children
        if childrens.include?(child)
            childrens.each_with_index do |kid,i| 
                self.children = childrens.take(i) + childrens.drop(i+1) if kid == child
            end
            child.parent = nil
        else
            raise "not a children"
        end
    end

    def dfs(target_value)
        return self if @value == target_value
        return nil if @children == []

        @children.each do |child|
            result = child.dfs(target_value)
            return result unless result == nil
        end
        nil
    end

    def bfs(target_value)
        myqueue = Queue.new
        myqueue.enqueue(self)

        until myqueue.queue.empty?
            current_node = myqueue.dequeue
            return current_node if current_node.value == target_value

            current_node.children.each {|child| myqueue.queue << child}
        end
        nil
    end
end
