require './config/environment'
#
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :'index'
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    # binding.pry
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if params[:content].length >0
      @tweet = Tweet.create(:content => params[:content])
      @tweet.user_id = current_user.id
      @tweet.save

      redirect "/tweets/#{@tweet.id}"
    else
      redirect "tweets/new"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content].length >0
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.delete
      redirect "/tweets"
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect "/tweets"
    end
  end

  post '/signup' do
    if params[:username].length >0 && params[:password].length >0 && params[:email].length >0
      @user=User.new(:username => params[:username], :password => params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect "/tweets"
      else
        redirect "/signup"
      end
    else
      redirect "/signup"# redirect to failure page
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect "/tweets"
    end
  end

  post '/login' do
    # binding.pry
    @user = User.find_by(:username => params[:username])
    if !!@user && @user.authenticate(params[:password])
    # if !!@user && @user.password == params[:password]
      # binding.pry
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets.all
    erb :'users/show'
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect "/login"
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
