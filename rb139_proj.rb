# rb139_proj.rb

=begin
Write a program that conforms to the above instructions and encrypts text strings
with the following simple (and very unsecure) cipher:

Replace each letter in the original string with another letter.
The first letter of the alphabet should be replaced with the last.
The second letter of the alphabet should be replaced with the next to last.
The third letter of the alphabet should be replace with the second from the last.
Continue on in this manner throughout the alphabet.
For example, the word money gets encrypted as nlmvb.


Create a class Cipher, with no initialize method
Create a class method, encode, that takes a string and returns and encoded string

Req
letter 1 to be replaced with letter 26
letter 2 to be replaced with letter 25
letter 3 to be replaced with letter 24
letter n to be replaced with letter 27 - n

Ignore punctuation and spaces
Ignore case

Return a lower case string separated into groups of 5 characters

Alg for alphanumeric
Create a string with only letters and numbers
Create a new empty string
Iterate through each character and append downcased character if it is alphanumeric


Alg for encode
Create a new_empty string, encoded
Iterate through characters in string, char
  append to encoded if char is a digit
  append to encoded the encoded_char


Alg for encoded char
Get the ord number for the char
Return the char for the ord number 97 + (27 - ord)

Alg for grouping string into 5s
Create new empty string

=end

class Cipher
  ALPHABET_SIZE = 26

  def self.encode(str)
    string = alphanumeric(str.downcase)
    encoded_string = ''
    string.each_char { |char| encoded_string << encoded(char) }
    format_spaces(encoded_string)
  end

  private

  class << self
    def alphanumeric(str)
      new_str = ''
      str.each_char do |char|
        new_str << char if char.match(/[a-z0-9]/)
      end
      new_str
    end

    def encoded(char)
      return char if char.match(/[0-9]/)
      char
      ord_num = char.ord
      alpha_place = ord_num - ('a'.ord - 1)
      new_alpha_place = (ALPHABET_SIZE + 1) - alpha_place
      new_ord_num = new_alpha_place + ('a'.ord - 1)
      new_ord_num.chr
    end

    def format_spaces(str)
      new_str = ''
      counter = 1
      str.each_char do |char|
        if counter <= 5
          new_str << char
          counter += 1
        else
          new_str << ' '
          new_str << char
          counter = 1
        end
      end
      new_str
    end
  end
end

# p Cipher.encode('M !9oney')

  # def self.format_spaces(str)
  #   new_char_arr = []
  #   char_arr = str.chars
  #   until char_arr.empty?
  #     new_char_arr << char_arr.slice!(0, 5)
  #     new_char_arr << ' '
  #   end
  #   new_char_arr.join('')
  # end