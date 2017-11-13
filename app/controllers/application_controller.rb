require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
  end

  ##### controller actions for users  ----> or add separate controller
  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?(session)
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      user.save
      session[:id] = user.id
      redirect to '/tweets'
    end
    redirect to '/users/signup'
  end

  get '/login' do
    if !logged_in?(session)
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end
#
  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
    redirect to '/tweets'
    end
    redirect to '/signup'
  end

  get '/logout' do
    if logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get "/users/:slug" do
    user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end



#    #### controller actions for tweets ----> or add separate controller
#
  get '/tweets' do
    @tweets = Tweet.all
    if logged_in?(session)
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?(session)
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      tweet = Tweet.new(params)
      tweet.user_id = session[:id]
      tweet.save
      redirect to '/tweets'
    end

    redirect to '/tweets/new'
  end

  get '/tweets/:id' do
    if logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if logged_in?(session) && User.current_user(session).id == @tweet.user_id
      erb :'/tweets/edit_tweet'
    elsif logged_in?(session) && User.current_user(session).id != @tweet.user_id
      redirect to '/tweets'
    elsif !logged_in?(session)
      redirect to '/login'
    end
  end

  post '/tweets/:id' do

    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  helpers do
    def logged_in?(session)
      !!session[:id]
    end
  end

end
