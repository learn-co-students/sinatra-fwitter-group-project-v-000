require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end
get '/tweets/new' do 
    if Helpers.is_logged_in?(session)
      erb :'/tweets/create_tweet'
    else 
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect :'/tweets/new'
    else
      user = User.find_by_id(session[:user_id])
      Tweet.create(content: params[:content], user_id: user.id)
    end

  end

  get '/tweets' do 

    if session[:user_id]
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect '/login'
    end
  end

  get '/users/:username' do
    @user = User.find_by(:username => params[:username])
    erb :'/users/show'
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do 
    if Helpers.is_logged_in?(session) 
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        erb :'/tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id' do
    if params[:content] != ""
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

  post '/tweets/:id/delete' do 
    if session[:user_id] 
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.delete
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end 

    get '/' do 
    erb :'users/index'
  end

  get '/signup' do 
    if !session[:user_id]
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id 
      redirect to '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect to '/login'
    else
       redirect '/tweets'
    end
  end
end