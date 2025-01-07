class Node 
  attr_accessor :value, :leftNode, :rightNode
  include Comparable

  def initialize
    @value = nil
    @leftNode = nil
    @rightNode = nil
  end

  def self.newNode(value)
    node = Node.new
    node.value = value
    node
  end

  def GetValueType 
    @value.class
  end

  def <=>(node)
    if node.is_a?(Node) 
      @value <=> node.value
    elsif node.is_a?(Numeric) 
      @value <=> node
    end
  end

end