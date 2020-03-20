# beer_song.rb

# rubocop:disable Metrics/LineLength
class BeerSong
  def verse(number)
    verse_collection(number)[number]
  end

  def verses(start, finish)
    verses_string = ''
    start.downto(finish + 1) do |num|
      verses_string << verse(num) << "\n"
    end
    verses_string << verse(finish)
  end

  def lyrics
    verses(99, 0)
  end

  private

  def verse_collection(qty)
    verse_array = [verse_0, verse_1, verse_2]
    3.upto(qty) do |num|
      verse_array << verse_x(num)
    end
    verse_array
  end

  def verse_0
    "No more bottles of beer on the wall, no more bottles of beer.\n" \
    "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
  end

  def verse_1
    "1 bottle of beer on the wall, 1 bottle of beer.\n" \
    "Take it down and pass it around, no more bottles of beer on the wall.\n"
  end

  def verse_2
    "2 bottles of beer on the wall, 2 bottles of beer.\n" \
    "Take one down and pass it around, 1 bottle of beer on the wall.\n"
  end

  def verse_x(qty)
    "#{qty} bottles of beer on the wall, #{qty} bottles of beer.\n" \
    "Take one down and pass it around, #{qty - 1} bottles of beer on the wall.\n"
  end
end
# rubocop:enable Metrics/LineLength

