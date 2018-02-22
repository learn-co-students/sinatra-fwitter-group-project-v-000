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

    # If logged in, go straight to /tweets
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    end

    erb :'/users/create_user'
  end

  # SIGN UP NEW USER
  post '/signup' do

    # Confirm username and email were entered
    if Helpers.signup_check(params)
      redirect '/signup'
    end
    
    # Create user in DB; log user into session
    user = User.create(params)
    session[:user_id] = user.id
    
    redirect '/tweets'
  end

  get '/tweets' do

    # Confirm user is logged in
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    end

    @user = Helpers.current_user(session)
    erb :'/tweets/tweets'

  end

  get '/login' do

    # If logged in, go straight to /tweets
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    end

    erb :'/users/login'
  end

  post '/login' do

    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end

  end

  get '/logout' do
    
    # Confirm user is logged in
    if !Helpers.is_logged_in?(session)
      redirect '/'
    end

    redirect '/login'

  end

  get '/users/:slug' do
    
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
    
  end

  get '/tweets/new' do

    # Confirm user is logged in
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    end

    erb :'tweets/create_tweet'

  end

  post '/tweets' do

    # Does not let user create blank tweet
    if params[:content] == ""
      redirect '/tweets/new'
    end

    tweet = Tweet.create(content: params[:content], user_id: session[:user_id])

    redirect "/tweets/#{tweet.id}"
  end

  get '/tweets/:id' do

    # Confirm user is logged in
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    end

    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  end

  # Edit Tweet Page (with Form)
  get '/tweets/:id/edit' do
    
    # Confirm user is logged in
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    end
    
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  end

  delete '/tweets/:id/delete' do
            
    # Confirm user is logged in
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    end

    tweet = Tweet.find(params[:id])

    # Does not let a user delete a tweet they did not create
    if tweet.user == Helpers.current_user(session)
      tweet.destroy
    end

    redirect '/tweets'
  end

  patch '/tweets/:id/edit' do
        
    # Confirm user is logged in
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    end

    @tweet = Tweet.find(params[:id])

    # Does not let user edit a tweet with blank content
    if params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    end

    @tweet.content = params[:content]
    @tweet.save
    
    redirect "/tweets/#{@tweet.id}"
  end

end

class Helpers

  def self.is_logged_in?(session)
    !!session[:user_id]
  end

  def self.current_user(session)
    User.find(session[:user_id])
  end

  def self.signup_check(params)
    params[:username] == "" || params[:email] == "" || params[:password] == ""
  end

end