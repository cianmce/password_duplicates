require 'set'

class Node
  attr_accessor :parents, :children, :text, :alive


  def initialize(text)
    @parents  = Set.new
    @children = Set.new
    @text     = text
    @alive    = true
  end

  def child_type(child)
    # returns type of parent or nil if this is a parent
    return nil if @text.length == 0
    return :invert_first_char if "#{@text[0].swapcase}#{@text[1..-1]}" == child.text
    return :invert_all        if @text.swapcase == child.text
    return :extra_letter      if @text.length > 1 && @text[0..-2] == child.text
    rescue => e
  end

  def alive?
    self.alive
  end

  def dead?
    !self.alive
  end

  def kill!
    self.alive = false
  end

  def remaining_parents
    self.parents.select { |n| n.alive }
  end

  def dependant_on?(node)
    # not a <=> b X
    self.remaining_parents == [node] # && node.remaining_parents != [self]
  end

  def is_dependant_on?
    self.children.each do |node|
      if node.dependant_on?(self)
        return true
      end
    end
    return false
  end

  def fully_dependant_on?(node)
    self.dependant_on?(node) && self.dead?
  end

  def is_fully_dependant_on?
    self.children.each do |node|
      if node.fully_dependant_on?(self)
        return true
      end
    end
    return false
  end

  def to_s
    text =  "<Node \"#{@text}\" \"#{self.alive? ? "alive" : "dead"}\" \n"
    # text += "parents=[#{self.parents.map(&:text).join(", ")}]\n"
    # text += "children=[#{self.children.map(&:text).join(", ")}]\n"
    # text += ">"
  end
end
