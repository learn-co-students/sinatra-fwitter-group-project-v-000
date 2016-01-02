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
    if session[:id] != nil
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
    if session[:id] != nil
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
<<<<<<< HEAD
=======
      session[:id] = @user.id
>>>>>>> 440600a5acd950868409d65b745bf359608dfce0
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if session[:id] != nil
      @user = User.find_by_id(session[:id])
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if session[:id] != nil
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/tweets/new' do
    if session[:id] != nil
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
<<<<<<< HEAD
    erb :"tweets/show_tweet"
=======
    if session[:id] != nil
      erb :"tweets/show_tweet"
    else
      redirect '/login'
    end
>>>>>>> 440600a5acd950868409d65b745bf359608dfce0
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if session[:id] == @tweet.user_id
      erb :"tweets/edit_tweet"
    else
      redirect '/tweets'
    end
  end

<<<<<<< HEAD
  post '/tweets/:id' do 
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect "/tweets/#{params[:id]}"
  end

=======
>>>>>>> 440600a5acd950868409d65b745bf359608dfce0
  get '/tweets/:id/delete' do

  end

<<<<<<< HEAD
=======
  get '/users/:slug' do
    @user = User.find_by_username(params[:slug])
    @tweets = Tweet.all
    erb :"users/show_user"
  end

>>>>>>> 440600a5acd950868409d65b745bf359608dfce0
end

















