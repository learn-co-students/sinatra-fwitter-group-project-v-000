class ApplicationController < Sinatra::Base
  use Rack::MethodOverride
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if !params.has_value?("")
      @user = User.new(params)
      if @user.save
        @user.save
        session[:id] = @user.id
        @session = session
        redirect '/tweets'
      else
        flash[:message] = "There was an error. Please try again."
        redirect '/signup'
      end
    else
      flash[:message] = "Error: Please fill out all fields."
      redirect '/signup'
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    if !params.has_value?("")
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:id] = @user.id
        @session = session
        flash[:message] = "Welcome, #{@user.username}!"
        redirect '/tweets'
      else
        flash[:message] = "Incorrect username or password."
        redirect '/login'
      end
    else
      flash[:message] = "Error: Please fill out all fields."
      redirect '/login'
    end
  end

  get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'/users/user' 
  end

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @user = Helpers.current_user(session)
      @tweet = Tweet.create(content: params[:content])
      @user.tweets << @tweet
      @user.save
      redirect "/tweets/#{@tweet.id}"
    else
      flash[:message] = "Error: Please fill out content."
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      flash[:message] = "Error: Please fill out content."
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @user = Helpers.current_user(session)
    @tweet = Tweet.find_by(id: params[:id])
    if @user.tweet_ids.include?(@tweet.id)
      @tweet.destroy
      redirect "/tweets"
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get "/logout" do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect "/login"
    else
      redirect '/'
    end
  end

end