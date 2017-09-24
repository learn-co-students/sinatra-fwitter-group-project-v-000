require './config/environment'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "blah"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    if logged_in?
      @user = current_user
      redirect '/tweets'
    else
      erb :signup
    end
  end

  post "/signup" do
    user = User.create(:username => params[:username],:email=>params[:email], :password=>params[:password])
    if user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :tweets
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :new
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect '/tweets/new'
    else
      Tweet.create(:user_id => session[:user_id], :content => params[:content])
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = current_user
      erb :show
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      if @user == @tweet.user
        erb :edit
      else
        redirect "/tweets/#{params[:id]}"
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      Tweet.find(params[:id]).update(:content => params[:content])
      redirect "/tweets/#{params[:id]}"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if current_user == tweet.user
      tweet.destroy
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end

  get "/login" do
    if logged_in?
      @user = User.find(session[:user_id])
      redirect '/tweets'
    else
      erb :login
    end
  end

  post "/login" do
    # binding.pry
    user = User.find_by(:username=>params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/failure'
    end
  end

  #Anyone has access to view a user's tweet
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :user
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
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

  #annoying chrome
  get "/favicon.ico" do
  end
end
