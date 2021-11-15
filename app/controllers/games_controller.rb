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
  # building?(answer, letters)
  api_url = "https://wagon-dictionary.herokuapp.com/#{answer}"
  dico_serialized = URI.open(api_url).read
  dico = JSON.parse(dico_serialized)
  # p dico
  # p found = dico['found']
  # p length = dico['length']
  # p test = building?(answer, letters)

# p letters.split('').join(',')

  if (test && found)
    @text_out = "Congratulations!! #{answer.upcase} is valid English Word!"
  elsif test
    @text_out = "Sorry but#{answer.upcase} does not seem to be valid English Word..."
  else
    @text_out = "Sorry but#{answer.upcase}  can't be built out of #{letters.upcase.split('').join(' ,')}"
  end
end

#   The word can’t be built out of the original grid
# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word


#F F F H V H N L O Y
end
