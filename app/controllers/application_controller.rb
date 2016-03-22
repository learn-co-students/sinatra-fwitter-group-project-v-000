require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :homepage
  end

  get '/signup' do
    if is_logged_in
      redirect '/tweets'
    else
      erb :index
    end
  end

  post '/signup' do
      if params[:username] != "" && params[:email] != "" && params[:password] != ""
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])
        session[:user_id] = @user.id
        redirect '/tweets'
      else
        redirect '/signup'
      end
  end

  get '/login' do
    if is_logged_in
      redirect "/tweets"
    else
      erb :"tweets/users/login"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect "/tweets"
     else
       redirect '/login'
     end
  end

  get "/logout" do
    if is_logged_in
      session.clear
      redirect "/login"
    else
      redirect "/"
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

  get '/tweets' do
    erb :"tweets/tweets"
  end

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    Tweet.create(content: params["content"])
    redirect "/tweets/#{Tweet.last.id}"
  end

  get '/tweets/:id' do
    @id = params[:id]
    @tweet = Tweet.find(@id)
    erb :'/tweets/show_tweet'
  end


  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

 patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.content = params["content"]
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    redirect "/tweets"
  end

end

