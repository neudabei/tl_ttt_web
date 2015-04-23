require 'sinatra'

helpers do

end

get '/' do
  redirect '/game'
end

get '/game' do
  erb :game
end

post '/choice' do
  session[:player_choice] = []
  params[:player_choice] << session[:player_choice]
  redirect '/game'
end


# Pseudocode

# store selection from user in hash, which is stored in session and increases >>
# define winning conditions
# automatically have computer select one after user chose (with sample method)
# display images (no image, x image, o image) according to hash
