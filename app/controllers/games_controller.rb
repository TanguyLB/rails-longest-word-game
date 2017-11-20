require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ("A".."Z").to_a.sample
    end
    p @letters
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split

    if in_grid?(@word, @letters)
      if translation?(@word)
        @score = "Congratulations! #{params[:word].upcase} is a valid English word!"
      else
        @score = "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
      end
    else
      @score = "Sorry but #{params[:word].upcase} can't be built our of #{@letters.join(",")}"
    end


    # url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    # document = open(url)
    # file = JSON.parse(document.read)
    # if file[:found] == false
    #   @score = "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
    # elsif word.each { |letter| @letters.include?(letter) } && word.count(letter) <= @letters.count(letter)
    #   @score = "Congratulations! #{params[:word].upcase} is a valid English word!"
    # else
    #   @score = "Sorry but #{params[:word].upcase} can't be built our of #{@letters.join(",")}"
    # end
  end

  def translation?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    document = open(url)
    file = JSON.parse(document.read)
    return file["found"]
  end

  def in_grid?(word, letters)
    word.upcase.split("").each do |letter|
      return false if word.count(letter) > letters.count(letter)
    end
    return true
  end
end
