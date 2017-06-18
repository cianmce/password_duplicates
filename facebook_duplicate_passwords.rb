require_relative 'graph'




dump_file = "dumps/rockyou_sorted.txt"
dump_file = "dumps/test_sorted.txt"

# build graph
graph = Graph.new dump_file

graph.build
puts graph.trie.get 'passw'
