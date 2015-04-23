require 'sinatra'
require 'pry'

set :sessions, true

helpers do
    def check_winner(player_choices, computer_choices) # pass in when calling method (session[:player_choice], session[:computer_choice]) 
      if player_choices == [1,2,3] || player_choices == [4,5,6] || player_choices == [7,8,9] || player_choices == [1,4,7] || player_choices == [2,5,8] || player_choices == [3,6,9] || player_choices == [1,5,9] || player_choices == [3,5,7]
        @success = "Player won!" 
      elsif computer_choices == [1,2,3] || computer_choices == [4,5,6] || computer_choices == [7,8,9] || computer_choices == [1,4,7] || computer_choices == [2,5,8] || computer_choices == [3,6,9] || computer_choices == [1,5,9] || computer_choices == [3,5,7] 
        @error = "Computer won!"
      end
    end
end

get '/' do
  redirect '/game'
end

get '/game' do
  erb :game
end

post '/choice' do
  session[:player_choice] = []
  session[:computer_choice] = []
  session[:player_choice] << params[:player_choice]
  # session[:computer_choice] << (1..9).sample

  check_winner(session[:player_choice],session[:computer_choice])

  # binding.pry
  redirect '/game'
end


# Pseudocode

# store selection from user in array, which is stored in session and increases with each click
# computer makes choice automatically based on sample/randomize method and also stores in array
# check winner (based on defined winning conditions)
# display images (no image, x image, o image) according to array content (1,2 || 1,2,3 ...)