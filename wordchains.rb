require 'Set'

class WordChainer
  attr_reader :dictionary

  def self.adjacent_words(word, dictionary)
    adjacent_words = []
    
    word.length.times do |index|
      ('a'..'z').each do |new_letter|
        next if word[index] == new_letter
        
        new_word = word.dup
        new_word[index] = new_letter
        adjacent_words << new_word if dictionary.include?(new_word)
      end
    end
    
    adjacent_words   
  end
  
  def initialize(file)
    @dictionary = load_dictionary(file)
  end
  
  def load_dictionary(file)
    File.readlines(file).map(&:chomp)
  end
  
  def find_word_chain(start_word, end_word)
    return if start_word.length != end_word.length
    
    @parents = { start_word => nil }
    current_words = [start_word]
    candidates = @dictionary.select do |word|
      word.length == start_word.length
    end
    
    candidates = Set.new(candidates - current_words)
    
    until candidates.empty?
      new_words = find_new_words(current_words, candidates)
      
      return find_path(end_word) if new_words.include?(end_word)
      
      candidates = Set.new(candidates.select{ |word| !new_words.include?(word) })    
      current_words = new_words 
      
    end 
    
    puts "there is no path"
  end
  
  
  private
  
    def find_new_words(current_words, candidates)
      new_words = []
      
      current_words.each do |word|
        new_children = WordChainer.adjacent_words(word, candidates)
        new_children.each do |new_word|
          @parents[new_word] = word
        
        end
        
        new_words += new_children
        
      end
      
      new_words
    end
    
    def find_path(end_word)
      word_path = [end_word]
      
      until word_path.last.nil?
        word_path << @parents[word_path.last]
      end
      
      word_path.reverse
    end 
end