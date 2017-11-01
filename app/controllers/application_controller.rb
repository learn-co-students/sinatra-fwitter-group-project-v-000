require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :home
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :login
    else
      redirect "/tweets"
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/tweets' do
    @user = User.find_by_id(session[:user_id])
    if @user && current_user
      erb :index
    else
      redirect '/login'
    end
  end

  get "/users/:slug" do #user show page
    @user = User.find_by_slug(:slug)
    if @user && current_user
      erb:show
    else
      redirect "login"
    end
  end

  get '/tweets/new' do
    user = User.find_by_id(session[:user_id])
    if user && current_user
      erb :new
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    user = User.find_by_id(session[:user_id])
    new_tweet = Tweet.create(:content => params[:content], :user_id =>  user.id)

    if user && current_user && new_tweet.valid?
      redirect "/tweets/#{new_tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    user = User.find_by_id(session[:user_id])
    @tweet = Tweet.find_by_id(params[:id])
    if user && current_user && @tweet
      #binding.pry
      erb :show_tweet
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in?
      erb :edit
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if current_user && params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    elsif current_user && !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/login'
    end

  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find_by_id(params[:id])
    if current_user.id == tweet.user_id
      tweet.delete
    else
      redirect '/tweets'
    end
  end

  helpers do
   def logged_in?
     !!session[:user_id]
   end

   def current_user
     User.find(session[:user_id])
   end
  end

end
