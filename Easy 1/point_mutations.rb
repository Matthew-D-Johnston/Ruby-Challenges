# point_mutations.rb

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
