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
    erb :'users/create_user'
  end

  post '/signup' do
    if !params[:username].empty? || !params[:email].empty? || !params[:password].empty?
      redirect 'users/create_user'
    else
      redirect 'tweets/tweets'
    end
  end

end
