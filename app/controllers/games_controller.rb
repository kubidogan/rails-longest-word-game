require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @guess = params[:guess]
    @letters = params[:letters].split
    @guess_array = @guess.upcase.chars
    letters_match = @guess_array.all? { |t| @guess.count(t) <= @letters.count(t) }
    if letters_match
      url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
      api_call = JSON.parse(URI.open(url).read)
      if api_call['found']
        @score = api_call['length']
        @message = 'Hooray, well done!'
      else
        @score = 0
        @message = "Sorry, #{@guess} is not a valid word"
      end
    else
      @score = 0
      @message = "Sorry, those characters aren't in the list of words"
    end
  end
end
