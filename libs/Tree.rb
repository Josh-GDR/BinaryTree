require_relative './Node.rb'

class Tree
    @root

    def initialize
        @root = nil
    end

    def self.BuildTree(elementArray)
        tree = Tree.new
        elementArray.each { |element| tree.insert(element) }
        tree
    end

    def insert(value = nil)
        return if value.nil?

        if @root.nil?
            @root = Node.newNode(value)
            return
        end
        if @root.GetValueType != value.class
            puts "Values from diferent classes"
            return
        end

        Insert(value)
    end

    private def Insert(value, actNode = @root)        
        if value == actNode.value
            puts '<-------->'
            return
        end

        if actNode < value
            puts '->'
            actNode.rightNode = Node.newNode(value) if actNode.rightNode.nil?
            Insert(value, actNode.rightNode)
        elsif actNode > value 
            puts '<-'
            actNode.leftNode = Node.newNode(value) if actNode.leftNode.nil?
            Insert(value, actNode.leftNode)
        end
    end

    def delete(value) 
        return if @root.nil?

    end

end