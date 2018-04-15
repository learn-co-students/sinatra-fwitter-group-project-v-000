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
    if !session[:user_id].nil?
      redirect '/tweets/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do

    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    elsif !session[:user_id].nil?
      @user = User.find(session[:user_id])
      redirect '/tweets/tweets'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets/tweets'
    end
  end

end
