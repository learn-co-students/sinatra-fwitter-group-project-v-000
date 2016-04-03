require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end
### INDEX ###
  get '/' do 
    erb :index
  end

### SIGNUP ###
  get '/signup' do 
    if Helpers.is_logged_in?(session)
      redirect "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do 
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if !@user.username.empty? && !@user.email.empty? && @user.password != nil
      @user.save
      session[:user_session_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

### LOGIN ###
  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post '/login' do 
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_session_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

### LOGOUT ###
  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  ### SHOW ALL TWEETS OF SPECIFIC USER ###
  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'users/show_tweets'
  end


### CREATE NEW TWEET ###
  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/create_tweet' 
    else
      redirect "/login"
    end
  end

  post '/tweets/new' do 
    @tweet = Tweet.new(:content => params["content"], :user_id => params["user_id"])
    if !@tweet.content.empty?
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

### SHOW ALL TWEETS ###
  get '/tweets' do 
    if Helpers.is_logged_in?(session)
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  ### SHOW SPECIFIC TWEETS ###
    get '/tweets/:id' do 
      if Helpers.is_logged_in?(session)
        @tweet = Tweet.find(params[:id])
        erb :'tweets/show_tweet'
      else
        redirect "/login"
      end
    end

### EDIT SPECIFIC TWEETS ###
  get '/tweets/:id/edit' do 
    if Helpers.is_logged_in?(session)
      @inquiring_user = Helpers.current_user(session)
      @tweet = Tweet.find(params[:id])
        if @inquiring_user.id == @tweet.user_id
          erb :'/tweets/edit_tweet'
        else
          redirect "/tweets"
        end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do 
    if params["content"].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.content = params["content"]
      @tweet.save
      redirect "/tweets"
    end
  end

  ### DELETE SPECIFIC TWEET
  delete '/tweets/:id/delete' do 
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweet = Tweet.find(params[:id])
      if @user.id == @tweet.id
        @tweet.destroy
        redirect "/tweets"
      else
        redirect "/tweets"
      end
    else
      redirect '/login'
    end
  end

end