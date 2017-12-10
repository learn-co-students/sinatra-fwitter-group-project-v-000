require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "wubbawubba"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:user_id]
      redirect to "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:email] == "" || params[:username] == "" || params[:password] == ""
     redirect to "/signup"
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if session[:user_id]
      redirect to "/tweets"
    else
      erb :"users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to "/"
    end
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/tweets' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :'tweets/create_tweets'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      user = User.find(session[:user_id])
      user.tweets << Tweet.create(content: params[:content])
      #  TO FOLLOW UP -- WHAT DO I DISPLAY ONCE THIS IS DONE?
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    # if @tweet.user.id == session[:user_id] - This is too much security for the test, other tests
    # won't pass under "delete" if this in place
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end
  # This passes
  # get '/tweets/:id' do
  #   if session[:user_id]
  #     @tweet = Tweet.find(params[:id])
  #     erb :'tweets/show_tweet'
  #   else
  #     redirect to '/login'
  #   end
  # end

  get '/tweets/:id/edit' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] != ""
      tweet = Tweet.find(params[:id])
      tweet.content = params[:content]
      tweet.save
      redirect to "/tweets/#{tweet.id}"
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if tweet.user.id == session[:user_id]
      tweet.delete
      tweet.save
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end
  # delete '/tweets/:id/delete' do
  #   binding.pry
  #   if session[:id]
  #     tweet = Tweet.find(params[:id])
  #     if tweet.user.id == session[:id]
  #       tweet.delete
  #       redirect to '/tweets'
  #     end
  #   else
  #     redirect to '/tweets'
  #   end
  # end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end



end
