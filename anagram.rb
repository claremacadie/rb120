# anagram.rb

=begin
Create a class, Anagram
Create an initialize method that takes a string and stores it as an instance
variable, word.
Create an instance method, match, that takes and array of strings and returns
a new array with only strings that are anagrams of word

Req
match should exclude the word itself

Alg for testing algorithms
Convert a string into and array of characters and sort it

=end

class Anagram
  attr_reader :word

  def initialize(str)
    @word = str
  end

  def match(arr)
    arr.keep_if do |str|
      anagram(str) && different(str)
    end
  end

  private

  def anagram(str)
    word.downcase.chars.sort == str.downcase.chars.sort
  end

  def different(str)
    word.downcase != str.downcase
  end
end

d = Anagram.new('corn')
p d.match(%w(corn Corn CORN cron))