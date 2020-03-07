##### Ruby Challenges > Easy 1

---

## Point Mutations

Write a program that can calculate the Hamming distance between two DNA strands.

A mutation is simply a mistake that occurs during the creation or copying of a nucleic acid, in particular DNA. Because nucleic acids are vital to cellular functions, mutations tend to cause a ripple effect throughout the cell. Although mutations are technically mistakes, a very rare mutation may equip the cell with a beneficial attribute. In fact, the macro effects of evolution are attributable by the accumulated result of beneficial microscopic mutations over many generations.

The simplest and most common type of nucleic acid mutation is a point mutation, which replaces one base with another at a single nucleotide.

By counting the number of differences between two homologous DNA strands taken from different genomes with a common ancestor, we get a measure of the minimum number of point mutations that could have occurred on the evolutionary path between the two strands.

This is called the 'Hamming distance'

```
1 | GAGCCTACTAACGGGAT
2 | CATCGTAATGACGGCCT
3 | ^ ^ ^  ^ ^    ^^
```

The Hamming distance between these two DNA strands is 7.

The Hamming distance is only defined for sequences of equal length. If you have two sequences of unequal length, you should compute the Hamming distance over the shorter length.

---

**Examples / Test Cases:** 

```ruby
DNA.new('').hamming_distance('') == 0
DNA.new('GGACTGA').hamming_distance('GGACTGA') == 0
DNA.new('ACT').hamming_distance('GGA') == 3

strand = 'GGACGGATTCTGACCTGGACTAATTTTGGGG'
distance = 'AGGACGGATTCTGACCTGGACTAATTTTGGGG'
DNA.new(strand).hamming_distance(distance) == 19

DNA.new('GGACG').hamming_distance('GGTCG') == 1
DNA.new('ACCAGGG').hamming_distance('ACTATGG') == 2

strand = 'GACTACGGACAGGGTAGGGAAT'
distance = 'GACATCGCACACC'
DNA.new(strand).hamming_distance(distance) == 5
```

---

**Data Structure:**  

**_Inputs_**

* Input to the `DNA` class: A String object representation of a DNA strand.
* Input to the `hamming_distance` instance method: A String object represenation of another DNA strand, to be compared with the original strand.

**_Outputs_**

* An Integer object representing the 'hamming distance' between the two strands.

---

**Algorithm:**

* The first thing we need to do is define a `DNA` class that takes a String object argument when a new object of the class is instantiated.
* Then we need to define a `hamming_distance` method that calculates the hamming distance between two strands; in other words we need to do an element-wise comparison of each String object.
* But to do this we need to determine the length of the shortest strand: `length_of_shortest_strand = [@strand.size, other_strand.size].min`
* We can then use the `upto` method, beginning at `0` and all the way upto `length_of_shortest_strand - 1`. We shall use these incremental iterations as the `index` of each string. 
* We will define initialize a `count` variable that is initially assigned to `0`.
* Within the block of the `upto` method we shall increment the `count` variable by when `@strand[index] != other_strand[index]`.

---

**Code:**

```ruby
class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(other_strand)
    length_of_shortest_strand = [@strand.size, other_strand.size].min
    count = 0

    0.upto(length_of_shortest_strand - 1) do |index|
      count += 1 if @strand[index] != other_strand[index]
    end

    count
  end
end
```

**Refactored:**

* changed the `count` variable to `distance`.

```ruby
class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(other_strand)
    length_of_shortest_strand = [@strand.size, other_strand.size].min
    distance = 0

    0.upto(length_of_shortest_strand - 1) do |index|
      distance += 1 if @strand[index] != other_strand[index]
    end

    distance
  end
end
```

