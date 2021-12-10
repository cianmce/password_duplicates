require_relative "node"

class Graph
  attr_accessor :nodes, :total_count, :tree, :invalid_count, :kill_count, :verbose

  def initialize(file_name)
    self.nodes = []
    self.tree = ({})
    self.total_count = 0
    self.invalid_count = 0
    self.kill_count = 0
    load_file(file_name)
    self.verbose = false
  end

  def load_file(file_name)
    File.open(file_name).each do |password|
      logger total_count if total_count % 100000 == 0
      begin
        self.total_count += 1

        password.chomp!
        node = Node.new(password)

        add_to_tree(node)

        nodes << node
      rescue ArgumentError => e
        self.invalid_count += 1
        self.total_count -= 1
        raise e unless e.message.include? "invalid byte sequence in UTF-8"
      end
      # if self.total_count == 1000000
      #   self.logger "\n\nBreaking:"
      #   self.logger password
      #   break
      # end
    end
  end

  def save_to_file(file_name)
    logger "Alive size: #{alive_nodes.length}"
    File.open(file_name, "w+") do |f|
      f.puts(alive_nodes.map { |n| n.text })
    end
  end

  def alive_nodes
    nodes.select { |n| n.alive? }
  end

  def build!
    # builds relationsships between nodes
    logger "Getting children"
    nodes.each_with_index do |node, i|
      logger i if i % 100000 == 0
      get_children(node)
    end
  end

  def reduce!
    logger "Killing"
    nodes.each_with_index do |node, i|
      logger i if i % 100000 == 0
      # has a parent and is not a sole deplendant
      if node.remaining_parents.length > 0 && !node.is_dependant_on?
        node.kill!
        self.kill_count += 1

        # self.logger "\n\n"
        # self.logger "_"*20
        # self.logger "Killing '#{node.text}': "
        # self.logger node.remaining_parents.map { |p| "#{p.text}: #{p.child_type(node)}" }.join(", ")
      end
    end
    reduce2!
  end

  def reduce2!
    # if you have no dead children depending on you and 1+ remaining_parents
    # -> self.kill!
    nodes.each_with_index do |node, i|
      if node.alive? && node.remaining_parents.length > 0 && !node.is_fully_dependant_on?
        node.kill!
      end
    end
  end

  def get_children(node)
    # returns nodes that are children
    possible_children = get_similar_nodes(node)

    possible_children.each do |possible_child|
      child_type = node.child_type(possible_child)
      if child_type
        node.children << possible_child
        possible_child.parents << node
      end
      # case child_type
      # when :invert_first_char, :invert_all, :extra_letter
      #   # self.logger "#{possible_child} - #{child_type}"
      #   # parent <-> parent
      #   # node.parents << possible_child
      #   # not needed as it'll be on their cycle
      #   # possible_child.parents << node
      # when :extra_letter
      #   # parent -> child
      #   # self.logger "#{possible_child} - extra"
      #   node.children << possible_child
      #   possible_child.parents << node
      # end
    end
  end

  def get_node(text)
    nodes = get_nodes_from_tree(text)
    nodes.each do |node|
      if node.text == text
        return node
      end
    end
  end

  def to_s
    "<#{file_name}>"
  end

  def logger(text)
    puts text if verbose
  end

  private

  def get_similar_nodes(node)
    possible_children = get_nodes_from_tree(node.text)
    possible_children += get_nodes_from_tree(node.text[0..-2]) if node.text.length > 1
    possible_children
  end

  def get_nodes_from_tree(text)
    tree[text.downcase] || []
  end

  def add_to_tree(node)
    password_downcase = node.text.downcase
    tree[password_downcase] = [] if tree[password_downcase].nil?
    tree[password_downcase] << node
  end
end
