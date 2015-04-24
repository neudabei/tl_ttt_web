require 'sinatra'
require 'pry'

set :sessions, true

WINNING_COMBINATIONS = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7], [3,2,1], [6,5,4], [9,8,7], [7,4,1], [8,5,2], [9,6,3], [9,5,1], [7,5,3], [2,3,1], [5,4,6], [8,7,9], [4,1,7], [5,2,8], [6,3,9], [5,1,9], [5,3,7], [1,3,2], [4,6,5], [7,9,8], [1,7,4], [2,8,5], [3,9,6], [1,9,5], [3,7,5]]

helpers do
    def check_winner(player_choices, computer_choices) # pass in when calling method (session[:player_choice], session[:computer_choice]) 
      if WINNING_COMBINATIONS.include?(player_choices) 
        @success = "Player won!" 
      elsif WINNING_COMBINATIONS.include?(computer_choices)
        @error = "Computer won!"
      elsif session[:available_choices].empty?
        @success = "It's a tie. There are no more available fields."
      else
        nil
      end
    end

  def image_output(num)
    if session[:player_choice].include?(num)
    "<form id='image_squares' action='/choice' method='post'>
                      <td><input type='hidden' name='player_choice' value='#{num}'> <input type='image' src='images/x.png'></td></form>"
    elsif session[:computer_choice].include?(num)
    "<form id='image_squares' action='/choice' method='post'>
                      <td><input type='hidden' name='player_choice' value='#{num}'> <input type='image' src='images/o.png'></td></form>"
    else
    "<form id='image_squares' action='/choice' method='post'>
                      <td><input type='hidden' name='player_choice' value='#{num}'> <input type='image' src='images/nil.png'></td></form>"
    end
  end

end

get '/' do
  redirect '/game'
end

get '/game' do
  session[:available_choices] = [1,2,3,4,5,6,7,8,9]
  session[:player_choice] = []
  session[:computer_choice] = []
  erb :game
end

post '/choice' do
  session[:player_choice] << params[:player_choice].to_i
  session[:available_choices].delete_at(params[:player_choice].to_i - 1) # take selected number from player out of available_choices
  check_winner(session[:player_choice],session[:computer_choice])
  computer_selection = session[:available_choices].sample # store computer_selection in local variable before passing it into array, so I can use the variable to also take it out of the available_choices array 
  session[:computer_choice] << computer_selection
  session[:available_choices].delete_at(computer_selection - 2) # take selected number from computer out of available_choices
  check_winner(session[:player_choice],session[:computer_choice])

  # binding.pry
  erb :game
end


# Pseudocode

# show all images from session[:available_choices] as blank images
# show all images from session[:computer_choice] as O images
# show all images from session[:player_choice] as X images

    # Code to check if field is taken
    # if session[:player_choice].include?(session[:available_choices])
    #   next
    # else 
    #   @error = "This field is taken. You can only choose between the available fields"
    #   halt erb :game
    # end