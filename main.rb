require 'sinatra'

helpers do

end

get '/' do
  redirect '/game'
end

get '/game' do
  erb :game
end

get '/choice' do
  session[:player_choice] =[]
  redirect '/game'
end


# Pseudocode

# store selection from user in hash, which is stored in session and increases >>
# display images (no image, x image, o image) according to hash
# define winning conditions
# automatically have computer select one after use chose (with sample method)