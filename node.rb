class Node
  attr_accessor :parents, :children, :text

  def initialize(text)
    @parents  = []
    @children = []
    @text = text
  end

  def parent_type(child)
    # returns type of parent or nil
    return nil if @text.length == 0
    return :invert_first_char if "#{@text[0].swapcase}#{@text[1..-1]}" == child.text
    return :invert_all        if @text.swapcase == child.text
    return :extra_letter      if @text.length > 1 && @text[0..-2] == child.text
    rescue => e
  end
end
