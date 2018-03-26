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
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params) #create both creates a new user and persists it to the database (saves it)
    end
    redirect '/tweets/index'
  end





  #logging in is simply storing the user's ID in the session hash.
  #logging out is simply clearing the session hash.










end
