require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    #added below
    enable :sessions
    set :session_secret, "hashtagwars"
  end

  get '/' do 
    erb :index
  end

  get '/login' do 
    if is_logged_in?
      redirect '/tweets'
    else
      erb :"users/login"
    end
  end

  post '/login' do
    @user = User.find_by_username(params[:username])
    session[:id] = @user[:id]
    if @user.password == params[:password]
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :"users/create_user"
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    end
    @user = User.find_by(username: params[:username])
    if @user == nil
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save

      session[:id] = @user.id

      redirect '/tweets'
    elsif @user.password == params[:password]
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if is_logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :"tweets/create_tweet"
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      new_tweet = Tweet.create(content: params[:content], user_id: session[:id])
      new_tweet.save
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    if is_logged_in?
      erb :"tweets/show_tweet"
    else
      redirect '/login'
    end

  end

  get '/tweets/:id/edit' do

    if session[:id] == nil
      redirect '/login'
    end
    @tweet = Tweet.find_by_id(params[:id])
    if session[:id] == @tweet.user_id

      erb :"tweets/edit_tweet"
    else
      redirect '/tweets'
    end
  end

  post '/tweets/:id/edit' do 

    if session[:id] == nil
      redirect '/login'
    end
    if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
    end 
    @tweet = Tweet.find_by_id(params[:id])
    if session[:id] == @tweet.user_id
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{params[:id]}"
    end

  end

  post '/tweets/:id/delete' do

    @tweet = Tweet.find_by_id(params[:id]) #finds correct tweet
    if session[:id] == @tweet.user_id 
      Tweet.find_by_id(params[:id]).delete

      redirect '/tweets'
    else
      redirect "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_username(params[:slug])
    @tweets = Tweet.all
    erb :"users/show_user"
  end

  private



    def is_logged_in?
      session[:id] != nil
    end

    def current_user
      User.find_by_id(session[:id])
    end

    



end


