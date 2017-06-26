require_relative "../graph"

describe Graph do
  before(:each) do
    file_name = "spec/test_dump.txt"
    @graph = Graph.new file_name
  end
  it "should" do
    @graph.build!
    @graph.reduce!
    # @graph.get_node()
    puts @graph.nodes
    puts @graph.alive_nodes.length
    expect(@graph.alive_nodes.length).to eq(6)
  end
end
