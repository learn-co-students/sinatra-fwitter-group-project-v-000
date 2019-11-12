require './config/environment'
#The ( :: ) symbol below is a unary operator that allows: constants, instance methods and class methods defined within a class or module, to be accessed from anywhere outside the class or module.
# Base class inside the ActiveRecord.Module
class ApplicationController < Sinatra::Base
  enable :sessions

  configure do
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do #home page
    erb :index
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
  end

    erb :"/users/create_user"
  end

  post '/signup' do
    params.each do |label, user_input|
      if user_input.empty?
      flash[:new_error] = "Please enter a value for #{label}"
      redirect to '/signup'
    end
  end

    user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
    session[:userid] = user.id

    redirect to '/tweets'
  end

  get '/login' do
    if Helpers.is_logged_in(session)
      redirect to '/tweets'
  end

    erb :"/users/login"
  end

    post '/login' do
      user = User.find_by(:username => params["username"])

      if user && user.authenticate(params[:password])
        session[:userid] = user.id
        redirect to '/tweets'

      else
        flash[:login_error] = "Incorrect login. Try again"
        redirect to '/login'
      end
    end

    get '/tweets' do
      if !Helpers.is_logged_in?(session)
        redirect to '/login'
      end

      @tweets = Tweet.all
      @user = Helpers.current_user(session)
      erb :"/tweets/tweets"
    end

    get '/tweets/new' do
      if !Helpers.is_logged_in(session)
        rediret to '/login'
    end

    erb :"/tweets/create_tweet"
  end

    post '/tweets' do
      user = Helperscurrent_user(session)
      if params["content"].empty?
        flash[:empty_tweet] = "Please enter your tweet content"
        redirect to '/tweets/new'
    end

      tweet = Tweet.new(:content => params["content"], :user_id => user.id)

      redirect to '/tweets'
    end

    get '/tweets/:id' do
      if !Helpers.is_logged_in(session)
        rediret to '/login'
      end
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet"
    end

    get '/tweets/:id/edit' do
      if !Helpers.is_logged_in(session)
        rediret to '/login'
      end

        @tweet = Tweet.find(params[:id])
        if Helpers.current_user(session).id != @tweet.user_id
          flash[:wrong_user_edit] = "I'm sorry, but you can only edit your own tweets"
          rediret to '/tweets'
        end

        erb :"/tweets/edit_tweet"
      end














end
