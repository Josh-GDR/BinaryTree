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
            return
        end

        if actNode < value
            actNode.rightNode = Node.newNode(value) if actNode.rightNode.nil?
            Insert(value, actNode.rightNode)
        elsif actNode > value 
            actNode.leftNode = Node.newNode(value) if actNode.leftNode.nil?
            Insert(value, actNode.leftNode)
        end
    end

    def delete(value) 
        return if @root.nil?

        prevNode = findFatherOf(value, @root)
        if prevNode.nil? and @root == value
            removeRoot
            return
        end

        actNode = findNode(value, prevNode)

        if actNode.isLeaf?
            removeLeaf(prevNode, value)
        elsif !actNode.leftNode.nil?
            actNode.value = getRightest(actNode.leftNode, actNode)
        elsif !actNode.rightNode.nil?
            actNode.value = getLeftest(actNode.rightNode, actNode)            
        end
    end

    private def removeLeaf(fatherNode, value)
        if fatherNode > value
            fatherNode.leftNode = nil
        else
            fatherNode.rightNode = nil
        end
    end

    private def removeRoot
        if @root.isLeaf?
            @root = nil
        elsif !@root.leftNode.nil?
            @root.value = getRightest(@root.leftNode, @root)
        elsif !@root.rightNode.nil?
            @root.value = getLeftest(@root.rightNode, @root)
        end
    end

    private def getLeftest(actNode, prevNode)
        return getLeftest(actNode.leftNode, actNode) unless actNode.leftNode.nil?
        
        value = actNode.value
        if actNode.isLeaf?
            removeLeaf(prevNode, actNode.value)
        elsif
            delete(actNode.value)
        end
        return value
    end

    private def getRightest(actNode, prevNode)
        return getRightest(actNode.rightNode, actNode) unless actNode.rightNode.nil?

        value = actNode.value
        if actNode.isLeaf?
            removeLeaf(prevNode, actNode.value)
        else
            delete(actNode.value)
        end
        return value
    end

    private def findFatherOf(value, actNode) 
        return nil if actNode.nil?

        if actNode > value 
            return actNode if not actNode.leftNode.nil? and actNode.leftNode == value
            findNode(value, actNode.leftNode) 
        elsif actNode < value
            return actNode if not actNode.rightNode.nil? and actNode.rightNode == value
            findNode(value, actNode.rightNode)
        end
    end

    def findNode(value, actNode = @root) 
        return nil if actNode.nil?

        return actNode if actNode == value 

        if actNode > value 
            findNode(value, actNode.leftNode) 
        elsif actNode < value
            findNode(value, actNode.rightNode)
        end
    end

    def height(value)
        treeBranch = findNode(value)
        return if treeBranch.nil?
        
        queue = Queue.new
        
        queue.push(treeBranch)
        height = -1
        until queue.empty? do
            iterations = queue.length
            height = height + 1
            
            for i in (0...iterations)
                node = queue.pop
                
                queue.push(node.leftNode) unless node.leftNode.nil?
                queue.push(node.rightNode) unless node.rightNode.nil?
            end
        end
        
        height
    end

    def depth(value)
        return if @root.nil?
        
        queue = Queue.new
        
        queue.push(@root)
        height = 0
        until queue.empty? do
            iterations = queue.length
            
            for i in (0...iterations)
                node = queue.pop
                
                if node == value
                    return height
                end
                
                queue.push(node.leftNode) unless node.leftNode.nil?
                queue.push(node.rightNode) unless node.rightNode.nil?
            end

            height = height + 1
        end

    end

    def printInorder(actNode = @root)
        return if actNode.nil?

        printInorder(actNode.leftNode)
        puts "['#{actNode.value}'] "
        printInorder(actNode.rightNode)
    end

end