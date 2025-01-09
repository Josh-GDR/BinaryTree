require  './libs/Tree.rb'

tree = Tree.BuildTree [50, 20, 60, 25, 55, 75, 24, 30, 29, 35, 40, 37]
p '<=======>'
tree.pretty_print
p '<=======>'
puts "balance: '#{tree.balanced?}'"
puts "balance: '#{tree.balanced?(:product)}'"
tree.rebalance
p '<=======>'
puts "balance: '#{tree.balanced?}'"
puts "balance: '#{tree.balanced?(:product)}'"
p '<=======>'
tree.pretty_print


# to do
# level_order {yield on each block and returns the value if the func is true}
# inorder yielding
# preorder yielding
# postorder yielding