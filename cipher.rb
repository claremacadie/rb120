class Cipher
  def self.encode(str)
    string_to_encode = alphanumeric(str.downcase)
    encoded_string = ''
    string_to_encode.each_char { |char| encoded_string << encoded(char) }
    format_spaces(encoded_string)
  end

  def self.alphanumeric(str)
    (str.chars.select do |char|
      char.match(/[a-z0-9]/)
    end).join('')
  end

  def self.encoded(char)
    return char if char.match(/[0-9]/)
    alphabet = ('a'..'z').to_a
    conversion = (alphabet.zip(alphabet.reverse)).to_h
    conversion[char]
  end

  def self.format_spaces(str)
    new_char_arr = []
    char_arr = str.chars
    until char_arr.empty?
      new_char_arr << char_arr.slice!(0, 5)
      new_char_arr << ' '
    end
    new_char_arr.join('').chop
  end
end
