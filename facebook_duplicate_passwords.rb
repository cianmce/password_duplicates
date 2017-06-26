require_relative 'graph'




file_name = "dumps/rockyou.txt"
file_name = "dumps/test.txt"
# file_name = "dumps/test_sorted.txt"
# file_name = "dumps/sample_graph.txt"
file_name = "output/rockyou_uniq_0.txt"



puts "Loading file: '#{file_name}"
graph = Graph.new file_name
puts "Loaded: #{graph.total_count} nodes\n\n"

graph.build!
graph.reduce!

output_file = "#{file_name.gsub(".txt", ".reduced.txt")}"
puts "Saving file: '#{output_file}"
graph.save_to_file(output_file)

puts "invalid count: #{graph.invalid_count}"
puts "kill count:    #{graph.kill_count}"


# n1 = graph.get_node("pass123word")
# n2 = graph.get_node("Pass123word")

# puts n1,n2

# puts n2.dependant_on?(n1)





# parent -> child
# parent <-> parent
# get all possible/parents of passw

# graph.alive_nodes.each do |node|
#   puts "\n_____________________________________"
#   puts node
# end

# n1 = graph.get_node("passw1")
# n2 =  graph.get_node("passw")
# n3 = graph.get_node("PASSW")
# # puts n1,n2,n3



# puts graph.get_node("PASS").is_dependant_on?

# puts graph.get_node("PASS")
# puts graph.get_node("PAS")
# puts graph.get_node("pass")
# puts graph.get_node("pASS")
# puts graph.get_node("Pass")
