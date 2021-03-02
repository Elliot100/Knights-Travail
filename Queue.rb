# Now let's write a Queue class. We will need the following instance methods: enqueue(el), dequeue, and peek.

class Queue
    attr_accessor :queue
    def initialize
        @queue = []
    end

    def enqueue(el)
        @queue.unshift(el)
    end

    def dequeue
        @queue.shift
    end

    def peek
        @queue[0]
    end

end