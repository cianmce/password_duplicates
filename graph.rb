require 'trie'
require_relative 'node'

class Graph
  attr_accessor :file_name, :nodes, :total_count, :trie

  def initialize(file_name)
    @nodes       = []
    @trie        = Trie.new
    @file_name   = file_name
    @total_count = 0
    self.load_file(file_name)
  end

  def load_file(file_name)
    puts "Loading file: '#{file_name}"
    File.open(file_name).each do |password|
      @total_count += 1

      password.chomp!
      node = Node.new(password)

      add_to_trie(password)

      @nodes << node
    end
    puts @total_count
  end

  def build
    # builds relationsships between nodes

  end

  def to_s
    "<#{@file_name}>\n#{@nodes}"
  end

  private

  def add_to_trie(password)
    password_downcase = password.downcase
    cur = @trie.get(password_downcase) || []
    cur << password
    @trie.add(password_downcase, cur)
  end
end
