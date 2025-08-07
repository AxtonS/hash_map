# Node creates node objects to be used within other data structures.
class Node
  attr_accessor :key, :value, :next_node

  def initialize(key:, value:, next_node: nil)
    @key = key
    @value = value
    @next_node = next_node
  end
end
