##### Ruby Challenges > Medium 1

---

## Protein Translation

**Problem:**  

Let's write a program that will translate RNA sequences into proteins. RNA can be broken into three nucleotide sequences called codons, and then translated to a polypeptide like so: 

```ruby
RNA: "AUGUUUUCU" => translates to

Codons: "AUG", "UUU", "UCU"
=> which become a polypeptide with the following sequence =>

Protein: "Methionine", "Phenylalanine", "Serine"
```

There are 64 codons which in turn correspond to 20 amino acids; however, all of the codon sequences and resulting amino acids are not important in this exercise.  

There are alos four terminating codons (also known as 'STOP' codons); if any of these codons are encountered (by the ribosome), all translation ends and the protein is terminated. All subsequent codons after are ignored, like this:

```ruby
RNA: "AUGUUUUCUUAAAUG" =>

Codons: "AUG", "UUU", "UCU", "UAA", "AUG" =>

Protein: "Methionine", "Phenylalanine", "Serine"
```

Note the stop codon terminates the translation and the final methionine is not translated into the protein sequence.--  

Below are the codons and resulting Amino Acids needed for the exercise.

| Codon              | Amino Acids   |
| :----------------- | :------------ |
| AUG                | Methionine    |
| UUU, UUC           | Phenylalanine |
| UUA, UUG           | Leucine       |
| UCU, UCC, UCA, UCG | Serine        |
| UAU, UAC           | Tyrosine      |
| UGU, UGC           | Cysteine      |
| UGG                | Tryptophan    |
| UAA, UAG, UGA      | STOP          |

---

**Examples / Test Cases:**  

```ruby
Translation.of_codon('AUG') == 'Methionine'
Translation.of_codon('UUU') == 'Phenylalanine'
Translation.of_codon('UUC') == 'Phenylalanine'
Translation.of_codon('UUA') == 'Leucine'
Translation.of_codon('UCG') == 'Serine'
Translation.of_codon('UAC') == 'Tyrosine'
Translation.of_codon('UGU') == 'Cysteine'
Translation.of_codon('UGG') == 'Tryptophan'
Translation.of_codon('UAG') == 'STOP'
Translation.of_rna('AUGUUUUGG') == ["Methionine", "Phenylalanine", "Tryptophan"]
Translation.of_rna('AUGUUUUAA') == ["Methionine", "Phenylalanine"]
Translation.of_rna('CARROT') # raises InvalidCodonError
```

---

**Data Structure:**  

**_Input_**

* For both the `of_codon` and `of_rna` methods the input is a String object.

**_Output_**

* A String object is output for the `of_codon` method.
* An Array object is output for the `of_rna` method.
* Both perform a translation of the given input. The `of_rna` method will make use of the output from the `of_codon` method.

**_Rules_**

* Should raise an `InvalidCodonError` if the input to the `of_rna` method does not match any of the possible combinations of codons.

---

**Algorithm:**

* I think we should start by creating a constant variable, `CODON_INDEX`, and assigning it to a Hash object, whose keys are the different Amino Acids and whose values are the sets of Codons that are associated with each Amino Acid.
* We should then define the implementation for our `of_codon` method, since our `of_rna` method will depend on it.
* `def of_codon(codon)`
  * We will want to iterate through the values of our `CODON_INDEX` hash and seeing if any of those keys contain the specific codon that we are translating.
  * If there is a match then we will want to return the key associated with the value in which the `codon` variable matched.
  * However, if there is no match, we will want to raise an `InvalidCodonError`.
* `def of_rna(strand)`
  * We want to begin by taking the given strand and splitting it into sets that are 3 characters in length, and then storing them in an array.
  * Let's begin by initializing an `amino_acids` variable assigned to an empty array
  * Next we will traverse the characters of our `strand` string 3-at-a-time by using the `times` and `slice` methods in conjunction with an `upper_index` variable that increments by three upon each iteration of the `times` method.
  * The calling object of the `times` method will be `strand.size / 3`.
  * 

---

**Code:**

```ruby
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
```









