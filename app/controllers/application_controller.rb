require './config/environment'

#use Rack::Session::Cookie, :secret => 'some_secret'

class ApplicationController < Sinatra::Base

  # configure do
  #   enable :sessions
  #   set :session_secret, "secret"
  # end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:id]
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.new(params)
      @user.save
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if session[:id]
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  get '/logout' do
      session.clear
      redirect '/users/login'
  end

  get '/tweets' do
    if session[:id]
      @user = Helpers.current_user(session)
      erb :'/tweets'
    else
      redirect '/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/users/login'
    end

  end

  get '/tweets/new' do
    if session[:id]
      erb :'/tweets/create_tweet'
    else
      redirect '/users/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content])
      @tweet.user_id = session[:id]
      @user = @tweet.user
      @user.tweets << @tweet
      erb :'/tweets/show_tweet'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if session[:id]
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if session[:id]
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if !params[:content].empty?
      @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end


  delete '/tweets/:id/delete' do

    if session[:id] == params[:id].to_i
      @tweet = Tweet.find(params[:id])
      @tweet.destroy
puts "in if statments"
    end
      redirect '/tweets'
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end
