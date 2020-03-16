# pig_latin.rb

class PigLatin
  def self.translate(words)
    words.split.map do |word|
      if word =~ /\b(x|y)[aeiou]/i
        x_and_y_scenario(word)
      else
        regular_scenario(word)
      end
    end.join(' ')
  end

  def self.regular_scenario(str)
    result = str.match(/\b([bcdfghjklmnpqrstvwxz]*qu|[bcdfghjklmnpqrstvwz]+)/i)
    result.nil? ? str + 'ay' : result.post_match + result.to_s + 'ay'
  end

  def self.x_and_y_scenario(str)
    result = str.match(/\b(x|y)[aeiou]/i)
    result.to_s[1] + result.post_match + result.to_s[0] + 'ay'
  end
end
