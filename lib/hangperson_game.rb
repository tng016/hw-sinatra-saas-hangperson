class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  def guess(letter)
    if !(/[a-z]/i =~ letter)
      raise ArgumentError
    end
    
    letter.downcase!
    
    if(word.include? letter)
      if(@guesses.include? letter)
        return false
      else
        @guesses+=letter
        return true
      end
    else
      if(@wrong_guesses.include? letter)
        return false
      else
        @wrong_guesses+=letter
        return true
      end
    end
  end
  
  def word_with_guesses()
    to_print = ''
    @word.split('').each do |letter|
      if @guesses.include? letter
        to_print += letter
      else
        to_print += '-'
      end
    end
    to_print
  end
  
  def check_win_or_lose()
    if wrong_guesses.length >= 7
      return :lose
    end
    
    @word.split('').each do |letter|
      if !@guesses.include? letter
        return :play
      end
    end
    
    return :win
  end

end
