require_relative "linked_list"

# HashMap implements a basic hash map data structure with customizable load
# factor and capacity.
# It provides methods for hashing keys and setting key-value pairs in the
# internal bucket array.
class HashMap
  attr_reader :load_factor
  attr_accessor :buckets, :capacity

  def initialize(load_factor: 0.75, capacity: 16)
    @load_factor = load_factor
    @capacity = capacity
    @buckets = Array.new(@capacity)
  end

  def hash(key:)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end

  def set(key:, value:)
    index = safe_index(key)
    grow
    buckets[index] = if buckets[index].nil?
                       Node.new(key: key, value: value)
                     else
                       handle_collision(buckets[index], key, value)
                     end
  end

  def get(key:)
    index = safe_index(key)

    buckets[index] || nil
  end

  def has?(key:)
    index = safe_index(key)

    buckets[index] ? true : false
  end

  def remove(key:)
    index = safe_index(key)

    return unless buckets[index]

    value = buckets[index]
    buckets[index] = nil
    value
  end

  def length
    buckets.count { |bucket| !bucket.nil? }
  end

  def clear
    buckets.fill(nil)
  end

  def keys
    buckets.map { |bucket| bucket&.key }.compact
  end

  def values
    buckets.map { |bucket| bucket&.value }.compact
  end

  def entries
    buckets.map { |bucket| [bucket&.key, bucket&.value] }.compact
  end

  private

  def safe_index(key)
    index = hash(key: key) % capacity
    raise IndexError if index.negative? || index >= buckets.length

    index
  end

  def handle_collision(existing, key, value)
    if existing.is_a?(Node)
      handle_node_collision(existing, key, value)
    elsif existing.is_a?(LinkedList)
      handle_list_collision(existing, key, value)
    end
  end

  def handle_node_collision(node, key, value)
    list = LinkedList.new(key: node.key, value: node.value)
    list.append(key: key, value: value)
    list
  end

  def handle_list_collision(list, key, value)
    pointer = list.head
    while pointer
      if pointer.key == key
        pointer.value = value
        return list
      end
      pointer = pointer.next_node
    end
    list.append(key: key, value: value)
    list
  end

  def grow
    return unless length >= capacity * load_factor

    self.capacity *= 2
    new_buckets = Array.new(capacity)
    buckets.each_with_index do |bucket, i|
      new_buckets[i] = bucket
    end
    self.buckets = new_buckets
  end
end
