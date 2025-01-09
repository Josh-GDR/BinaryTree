require_relative './Node.rb'

class Tree
    @root
    @AVL_Tree_Mode

    def initialize(balance = true)
        @root = nil
        @AVL_Tree_Mode = balance
    end

    def self.BuildTree(elementArray)
        tree = Tree.new(false)
        elementArray.each { |element| tree.insert(element) }
        tree
    end

    def self.BuildBalancedTree(elementArray)
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
        if (@AVL_Tree_Mode and balanced?)
            rebalance
        end
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

    def remove(value)
        delete(value)
        if (@AVL_Tree_Mode and balanced?)
            rebalance
        end
    end

    private def delete(value) 
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
        return -1 if treeBranch.nil?
        return 0 if treeBranch.isLeaf?
        
        queue = Queue.new
        
        queue.push(treeBranch)
        height = 0
        until queue.empty? do
            iterations = queue.length
            
            for i in (0...iterations)
                node = queue.pop
                
                queue.push(node.leftNode) unless node.leftNode.nil?
                queue.push(node.rightNode) unless node.rightNode.nil?
            end
            height = height + 1
        end
        
        height
    end

    def depth(value, actNode = @root)
        return -1 if actNode.nil? #The value doesn't exist
        return 0 if actNode == value #The value was found

        if actNode > value 
            val = depth(value, actNode.leftNode) 
            return val >= 0 ? 1 + val : -1
        elsif actNode < value
            val = depth(value, actNode.rightNode)
            return val >= 0 ? 1 + val : -1
        end
    end

    def balanced?(symb = :bool)
        return true if @root.nil? and @root.isLeaf?
        leftSubtree = @root.leftNode.nil? ? 0 : height(@root.leftNode.value)
        rightSubtree = @root.rightNode.nil? ? 0 : height(@root.rightNode.value)
        product = leftSubtree - rightSubtree
        
        if symb == :bool
            return (product >= -1 and product <= 1)        
        elsif symb == :product
            return product
        end
    end

    def rebalance
        product = balanced?(:product)

        if (product > 1)
            auxVal = @root.value
            @root.value = getRightest(@root.leftNode, @root)
            insert(auxVal)
            rebalance
        elsif product < -1
            auxVal = @root.value
            @root.value = getRightest(@root.rightNode, @root)
            insert(auxVal)
            rebalance
        end
        
    end

    def printInorder(actNode = @root)
        return if actNode.nil?

        printInorder(actNode.leftNode)
        puts "['#{actNode.value}'] "
        printInorder(actNode.rightNode)
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.rightNode, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.rightNode
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.leftNode, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.leftNode
      end

end