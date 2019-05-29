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
    @new_user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
    else
      redirect "/tweets"
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      erb :index
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  get '/tweets/:id' do

  end

  get '/tweets/:id/edit' do

  end

  post '/tweets/:id' do

  end

  post '/tweets/:id/delete' do

  end


  post '/tweets' do
    @tweet = Tweet.create(content: params[:content])

  end

end
