require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end


  get '/' do
    erb :index
  end

  

  get '/signup' do
    redirect "/tweets" if Helpers.is_logged_in?(session)
    erb :'users/create_user'
  end

  post "/signup" do
    redirect "/tweets" if Helpers.is_logged_in?(session)
    if params[:username].nil? || params[:username].length <= 0 || params[:email].nil? || params[:email].length <= 0 || params[:password].nil? || params[:password].length <= 0
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end
  
  get '/login' do
    redirect "/tweets" if Helpers.is_logged_in?(session)
    # session[:user_id] = @user.id
    
    erb :"/users/login"
    
  end
  
  
  post '/login' do
  
    # if (@user = User.find_by(username: params[:username])) && @user.password == params[:password]
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password]) 
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
  
  # get '/tweets' do
  #   @user = Helpers.current_user(session)
  #   @tweets = Tweet.all
  #   erb :'/tweets/tweets'
  
  # end
  
  get '/logout' do
    session.clear
    redirect '/login'
  end
  
  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if Helpers.is_logged_in?(session)
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    user = Helpers.current_user(session)
    tweet = Tweet.new(content: params[:content])
    if tweet.save
      user.tweets << tweet
      user.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect '/tweets/new'
    end
  end
  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if Helpers.is_logged_in?(session)
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    tweet.content = params[:content]
    if tweet.user.id == Helpers.current_user(session).id && tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if Helpers.is_logged_in?(session) && @tweet.user == Helpers.current_user(session)
      @tweet.delete
      redirect '/tweets'
    
    end
  
  end


end
