require 'open-uri'
require 'json'
# documentation :)
class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    10.times { @letters << alphabet.sample }
    # p letter_deck
  end

  def building?(guess, grid)
    # p guess
    # p grid
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def score
    answer = params[:answer]
    letters = params[:letters].downcase

    dico = api(answer)

    if building?(answer, letters)
      return @text_out = "Congratulations!! #{answer.upcase} is valid English Word!" if dico['found']

      @text_out = "Sorry but#{answer.upcase} does not seem to be valid English Word..."
      # if dico['found']
      #   @text_out = "Congratulations!! #{answer.upcase} is valid English Word!"
      # else
      #   @text_out = "Sorry but#{answer.upcase} does not seem to be valid English Word..."
      # end
    else
      @text_out = "Sorry but#{answer.upcase}  can't be built out of #{letters.upcase.split('').join(' ,')}"
    end

    # if building?(answer, letters) && dico['found']
    #   @text_out = "Congratulations!! #{answer.upcase} is valid English Word!"
    # elsif building?(answer, letters)
    #   @text_out = "Sorry but#{answer.upcase} does not seem to be valid English Word..."
    # else
    #   @text_out = "Sorry but#{answer.upcase}  can't be built out of #{letters.upcase.split('').join(' ,')}"
    # end
  end

  private

  def api(answer)
    api_url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    dico_serialized = URI.open(api_url).read
    JSON.parse(dico_serialized)
  end
end
