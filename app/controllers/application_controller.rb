require './config/environment'
# require './app/models/user'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "password_security"
  end

#--- Main Fwitter homepage ---
  get '/' do
    erb :'/index'
  end

#--- Tweet Homepage ---

  get '/tweets' do
    if !logged_in
      redirect '/login'
    else
      erb :'/tweets/tweets'
    end
  end

#--- signup ---
  get '/signup' do
    if !logged_in #user can't view signup page in logged_in
      erb :'users/signup'
    else
      redirect "/tweets"
    end
  end

  post '/signup' do
    if params.has_value?("")
      redirect "/signup"
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

#--- login ---
  get '/login' do
    if !logged_in #user can't view login page in logged_in
      erb :'/login'
    else
      redirect "/tweets"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

#--- logout ---
  get '/logout' do
    if !logged_in
      redirect "/"
    else
      session.clear
      redirect "/login"
    end
  end

#--- user show page ---

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

#--- new action ---

  get '/tweets/new' do
    if !logged_in
      redirect '/login'
    else
      erb :'/tweets/new'
    end
  end

  post '/tweets' do
    # binding.pry
    if params[:content] == ""
      redirect "/tweets/new"
    else
      @tweet = current_user.tweets.create(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

#--- show action ---

  get '/tweets/:id' do
    if !logged_in
      redirect '/login'
    else
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/show'
    end
  end


#--- edit action ---

  get '/tweets/:id/edit' do
    if !logged_in
      redirect '/login'
    else
      @tweet = Tweet.find_by(params[:id])
      if @tweet.user_id == current_user.id
        erb :"/tweets/edit"
      else
        redirect :'/tweets'
      end
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

#--- delete action ---

  delete '/tweets/:id/delete' do
    if !logged_in
      redirect '/login'
    else
      @tweet = Tweet.find_by(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect "/tweets"
      else
        redirect "/tweets/#{@tweet.id}/delete"
      end
    end
  end

#--- helper methods ---
  def current_user
    User.find_by(session[:user_id])
  end

  def logged_in
    !!session[:user_id]
  end

end
