require  './libs/Tree.rb'

tree = Tree.BuildTree [50, 20, 60, 25, 55, 75, 24, 30, 29]
tree.printInorder()

tree.delete(50)
tree.delete(60)
tree.printInorder()

# to do
# level_order {yield on each block and returns the value if the func is true}
# inorder yielding
# preorder yielding
# postorder yielding
# height {enters a node and goes down to the end}
# depth {height(root)}
# balanced
# rebalance