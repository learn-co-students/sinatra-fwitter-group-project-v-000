require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    #sign in user using params
    #add user_id to sessions hash
    redirect to '/tweets/tweets'
  end

end
