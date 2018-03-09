require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end


  get '/' do
    erb :home
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :login
    end
  end

  post '/login' do
    if login(params[:username], params[:password])
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      logout
      redirect "/login"
    else
      redirect "/"
    end
  end

  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    redirect '/tweets/new' if params[:content] == ""
    this_user.tweets.build(content: params[:content]).save 
    redirect "/tweets"
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end 
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in?
      erb :'tweets/show' 
    else 
      redirect '/login'
    end    
  end

  get '/tweets/:id/edit' do
    redirect "/login" if !logged_in?
    @tweet = Tweet.find(params[:id])
    if this_user.tweets.include?(@tweet)
      erb :'tweets/edit'
    else
      redirect "/tweets"
    end 
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content] 
      @tweet.save 
      redirect "tweets/#{@tweet.id}"
    end 
  end

  get '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if this_user.tweets.include?(tweet)
      tweet.destroy
      redirect '/tweets'
    else 
      redirect '/tweets'      
    end
  end

  get '/signup' do
    session = {}
    if logged_in?
      redirect '/tweets'
    else
      erb :new
    end
  end

  post '/signup' do
    @user = User.new(params)

    if @user.username != "" && @user.email != "" && @user.save
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect '/signup'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :show
  end

  helpers do

    def this_user
      User.find(session[:id])
    end

    def logged_in?
      !!session[:id]
    end

    def login(username, password)
      user = User.find_by(username: username)
      if user && user.authenticate(password)
        session[:id] = user.id
      else
        nil
      end
    end

    def logout
      session.clear
    end
  end

end
