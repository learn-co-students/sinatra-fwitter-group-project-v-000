require './config/environment'
require "rack-flash"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    use Rack::Flash
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
    erb :'/users/create_user'
  end
  end

  post '/signup' do
    @user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
    if @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else redirect '/login'
    end
  end

  post '/tweets/new' do
    if params["content"] != ""
      @tweet = Tweet.create(:content => params["content"], :user_id => session["user_id"])
      erb :'tweets/show_tweet'
    else redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(:id => params[:id])
      erb :'tweets/show_tweet'
    else redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(:id => params[:id])
      if @tweet.user_id == current_user.id
        erb :'tweets/edit_tweet'
      else redirect '/tweets'
      end
    else redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    if logged_in?
      if params["content"] != ""
        @tweet = Tweet.find_by(:id => params[:id])
        if @tweet.user_id == current_user.id
          @tweet.update(:content => params["content"])
          flash[:message] = "Your tweet has been edited"
          erb :'tweets/show_tweet'
        else redirect '/login'
        end
      else erb '/tweets/#{@tweet.id}/edit'
      end
    else redirect '/login'
    end
  end


  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by(:id => params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        flash[:message] = "Your tweet has been deleted"
        redirect '/tweets'
      end
    else redirect '/login'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'/users/login'
  end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = "Welcome, #{@user.username}"
      redirect '/tweets'
    else redirect '/login'
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect :'/'
    end
	end

  get '/users/:username' do
    @user = User.find_by(:username => params[:username])
    @tweets = @user.tweets.all
    erb :'/users/show'
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
