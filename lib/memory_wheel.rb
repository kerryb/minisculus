class MemoryWheel
  def encode original_text, encoded_text
    keys = [
      "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
      "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
      "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
      "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
      "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
      ".", ",", "?", "!", "'", "\"", " "
    ]

    offset = 0
    letters = encoded_text.chars.enum_with_index.map do |char, index|
      position = keys.find_index char
      encoded_letter = keys[(position + offset) % keys.length]
      offset = keys.find_index(original_text[index, 1]) * 2
      encoded_letter
    end

    letters.join
  end
end
