require_relative "lib/hashmap"

test = HashMap.new
test.set(key: "apple", value: "red")
test.set(key: "banana", value: "yellow")
test.set(key: "carrot", value: "orange")
test.set(key: "dog", value: "brown")
test.set(key: "elephant", value: "gray")
test.set(key: "frog", value: "green")
test.set(key: "grape", value: "purple")
test.set(key: "hat", value: "black")
test.set(key: "ice cream", value: "white")
test.set(key: "jacket", value: "blue")
test.set(key: "kite", value: "pink")
test.set(key: "lion", value: "golden")
puts test.length
puts test.capacity
puts test.entries
puts (test.length / test.capacity).to_f
