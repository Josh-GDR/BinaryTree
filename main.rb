require  './libs/Tree.rb'

tree = Tree.BuildTree [50, 20, 60, 25, 55, 75, 24, 30, 29]
tree.printInorder()


tree.delete(50)
tree.delete(60)

p '<=======>'
puts "height of 75:'#{tree.height(75)}'"
puts "height of 20:'#{tree.height(20)}'"
p '<=======>'
puts "depth of 75:'#{tree.depth(75)}'"
puts "depth of 30:'#{tree.depth(30)}'"
p '<=======>'

tree.printInorder()

# to do
# level_order {yield on each block and returns the value if the func is true}
# inorder yielding
# preorder yielding
# postorder yielding
# balanced
# rebalance