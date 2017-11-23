require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
  erb :index
  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    tweet = Tweet.create(params)
    tweet.save
    redirect('/tweets')
  end

  get '/tweets' do
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/signup' do
    if !session
     erb :'users/create_user'
    else
    redirect('/tweets')
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect('/signup')
    else
    redirect('/tweets')
  end
end


  get '/login' do
    erb :'users/login'
  end

   post '/login' do
    @user = User.find_by(username: params[:username])
    if @user != nil && @user.password == params[:password]
     
      session[:user_id] = @user.id
      redirect to '/tweets'
    else 
      erb :index
    end
  end
  








end