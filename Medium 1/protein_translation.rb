# protein_translation.rb

class Translation
  CODON_INDEX = { 'Methionine' => %w[AUG],
                  'Phenylalanine' => %w[UUU UUC],
                  'Leucine' => %w[UUA UUG],
                  'Serine' => %w[UCU UCC UCA UCG],
                  'Tyrosine' => %w[UAU UAC],
                  'Cysteine' => %w[UGU UGC],
                  'Tryptophan' => %w[UGG],
                  'STOP' => %w[UAA UAG UGA] }.freeze

  def self.of_codon(codon)
    amino_acid = nil

    CODON_INDEX.values.each do |codon_list|
      amino_acid = CODON_INDEX.key(codon_list) if codon_list.include?(codon)
    end

    raise InvalidCodonError, 'codon does not exist' if amino_acid.nil?

    amino_acid
  end

  def self.of_rna(strand)
    amino_acids = []
    lower_idx = 0

    (strand.size / 3).times do
      upper_idx = lower_idx + 2
      amino_acid = of_codon(strand.slice(lower_idx..upper_idx))
      break if amino_acid == 'STOP'

      amino_acids << amino_acid
      lower_idx += 3
    end

    amino_acids
  end
end

class InvalidCodonError < StandardError; end
