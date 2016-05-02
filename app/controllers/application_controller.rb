require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    enable :sessions
    set :public_folder, 'public'
  end

  get '/' do
    #binding.pry
    erb :index
  end

  get '/signup' do
    if is_logged_in
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  get '/users/:slug' do
    @user = User.find_by(username: params[:slug])

    erb :'/tweets/tweets'
  end

  post '/signup' do
    binding.pry
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.find_or_create_by(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    #binding.pry
    if is_logged_in
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    #assign session
    #binding.pry
    @user = User.find_by(params)
    #binding.pry
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      @tweets = @user.tweets
      redirect '/tweets'
    else
      redirect '/'
    end
  end

  get '/tweets' do
    #binding.pry
    if is_logged_in
      @tweets = Tweet.all
      erb :tweets
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in
      erb :create_tweet
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.find_or_create_by(params[:content])

    if params[:content] == "" 
      redirect '/tweets/new'
    else
      @user = current_user
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    #binding.pry
    @tweet = Tweet.find_by(params[:id])
    if is_logged_in
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    #binding.pry
    @user = User.find_by(params[:id])
    if is_logged_in || @user
      @tweets = @user.tweets
      erb :edit_tweet
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    #binding.pry
    if params[:content].empty?
      erb :'/tweets/:id/edit', locals: {message: "Your tweet had no content, please add content."}
    else
      @tweet = Tweet.find_or_create_by(params)
    end

    redirect '/tweets'
  end

  post '/tweets/:id/delete' do
    binding.pry
    if is_logged_in
      current_user.tweets.find_by(params[:id]).destroy
      redirect '/tweets'
    else
      redirect '/login'
    end
    #delete tweet
    #redirect '/tweets'
  end

  get '/logout' do
    #clear session
    if is_logged_in
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end

  helpers do
    def is_logged_in
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end