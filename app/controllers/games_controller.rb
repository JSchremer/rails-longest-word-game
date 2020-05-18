require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    set = ('A'..'Z').to_a
    @letters = Array.new(10) { set.sample }
  end

  def score
    @answer = params[:attempt].upcase
    @letters = params[:letters]
    @output = ""
    if english?(@answer) && correct_letters?(@answer, @letters)
      @output = "well done"
    elsif english?(@answer) == false && correct_letters?(@answer) == true
      @output = "Nice try, but not an English a word"
    elsif english?(@answer) == false && correct_letters?(@answer) == false
      @output = "Not a word"
    end
  end

  private
  def english?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    read_api = open(url).read
    word = JSON.parse(read_api)
    word['found']
  end

  def correct_letters?(attempt, letters)
    attempt.chars.all? { |x| attempt.count(x) <= letters.chars.count(x) }
  end

end
