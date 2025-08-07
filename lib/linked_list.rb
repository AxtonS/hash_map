require_relative "node"

# LinkedList holds methods and creates new linked lists.
class LinkedList
  attr_accessor :head

  def initialize(key:, value:)
    self.head = Node.new(key: key, value: value)
  end

  def append(key:, value:)
    pointer = head
    pointer = pointer.next_node until pointer.next_node.nil?

    pointer.next_node = Node.new(key: key, value: value)
  end

  def prepend(key:, value:)
    pointer = head
    self.head = Node.new(key: key, value: value, next_node: pointer)
  end

  def size
    counter = 1
    pointer = head
    until pointer.next_node.nil?
      pointer = pointer.next_node
      counter += 1
    end
    counter
  end

  def tail
    pointer = head
    pointer = pointer.next_node until pointer.next_node.nil?

    pointer
  end

  def index(num:)
    counter = 0
    pointer = @head
    while counter < num
      return nil if pointer.next_node.nil?

      pointer = pointer.next_node
      counter += 1
    end
    pointer
  end

  def pop
    pointer = head
    pointer = pointer.next_node until pointer.next_node.next_node.nil?
    pointer.next_node = nil
  end

  def contains?(value:)
    pointer = @head
    until pointer.next_node.nil?
      return true if pointer.value == value

      return false if pointer.next_node.nil?

      pointer = pointer.next_node
    end
    pointer.value == value
  end

  def find(value:)
    index = 0
    pointer = @head
    return false if contains?(value: value) == false

    until pointer.value == value
      pointer = pointer.next_node
      index += 1
    end
    index
  end

  def to_s
    pointer = @head
    string = "(#{pointer.value})"
    until pointer.next_node.nil?
      pointer = pointer.next_node
      string << " -> (#{pointer.value})"
    end
    string << " -> nil"
    string
  end

  def insert_at(key:, value:, index:)
    if index > size - 1
      append(key: key, value: value)
      nil
    elsif index < 1
      prepend(key: key, value: value)

      nil
    else
      index(index - 1).next_node = Node.new(key: key, value: value, next_node: index(index))
    end
  end

  def remove_at(index:)
    if index < 1
      self.head = head.next_node
    elsif index > size - 1
      index(num: size - 1).next_node = nil
    else
      index(num: index - 1).next_node = index(num: index + 1)
    end
  end
end
