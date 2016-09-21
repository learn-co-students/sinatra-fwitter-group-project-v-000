require './config/environment'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  # this is an index page 
  # should expect logic for redirects to login, and signup
  get '/' do  
    erb :index
  end

  # the tweets index page
  # this appears to be the users homepage once they're signed in
  # can grab a users specific tweets - a user has many tweets
  get '/tweets' do 

      if current_user
        @user = current_user
        erb :'tweets/tweets'
      else
        redirect to '/login'
      end
  end

  # Signup with a username, login, password
  # If a session is logged in - it should redirect to the users page
  get '/signup' do 
    if logged_in?  # if a user session isnt already live, populate the signup
      redirect to '/tweets'
    else
      erb :'/signup'
    end
  end

  # catches the signup params - creates a new user - and logs them into the tweets homepage
  post '/signup' do 
    if params.values.any? { |el| el.empty? }
      redirect to '/signup'
    else 
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do 
    
    if logged_in? # if a user session isnt already live, populate the signup
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do 
    @user = User.find_by(username: params[:username])
  
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do 
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    
    erb :'/users/user_homepage'
  end

  get '/tweets/new' do 
    @user = current_user

    if @user
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    @user = current_user

    if params[:content].empty?
      redirect '/tweets/new'
    else
      @tweet = Tweet.new(content: params[:content], user_id: @user.id)
      @tweet.save
      @user.tweets << @tweet 
      @user.save
      redirect to '/tweets'
    end
  end

  get '/tweets/:id' do 
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do 
    redirect to '/login' if !logged_in?

    @tweet = Tweet.find(params[:id])
    
    if @tweet.user_id == current_user.id
      erb :'tweets/edit_tweet'
    elsif current_user.id != @tweet.user_id
      redirect to '/tweets'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    redirect to "/tweets/#{@tweet.id}/edit" if params[:content].empty?
    
    if logged_in? && @tweet.user_id == current_user.id
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets"
    end 
  end

  # needs logic that allows me to 
  # make sure the tweet id belongs to the logged 
  # user 
  delete '/tweets/:id/delete' do #delete action
  @tweet = Tweet.find(params[:id])
  if current_user.id == @tweet.user_id 
    @tweet.delete
    redirect to '/tweets'
  else
    redirect to '/tweets'
  end
end


helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find_by_id(session[:id])
    end
  end














end