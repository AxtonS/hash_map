require_relative "node"

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
    index = hash(key: key) % capacity
    raise IndexError if index.negative? || index >= buckets.length

    grow
    buckets[index] = Node.new(key: key, value: value)
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

  def get(key:)
    index = hash(key: key) % capacity
    raise IndexError if index.negative? || index >= buckets.length

    buckets[index] || nil
  end

  def has?(key:)
    index = hash(key: key) % capacity
    raise IndexError if index.negative? || index >= buckets.length

    buckets[index] ? true : false
  end

  def remove(key:)
    index = hash(key: key) % capacity
    raise IndexError if index.negative? || index >= buckets.length

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
end
