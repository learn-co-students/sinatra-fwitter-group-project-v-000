require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'flatiron'
  end

  get '/signup' do
    if session[:id] != nil
      redirect "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:email].empty? || params[:username].empty? || params[:password].empty?
      redirect "/signup"
    else
      @user = User.create(:email => params[:email], :username => params[:username], :password => params[:password])
      session[:id] = @user.id
    end
    redirect to "/tweets"
  end

  get '/login' do
    if session[:id] != nil 
      redirect to "/tweets"
    else 
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.all.find_by(params[:user])
    session[:id] = @user.id

    redirect to "/tweets"
  end

  get '/logout' do
    if session[:id] != nil
      session.clear
    else
      redirect "/login"
    end
    redirect "/login"
  end

  get "/tweets/new" do
    if session[:id] != nil
      @user = User.find(session[:id])
      erb :'tweets/create_tweet'
    else
      redirect to "/login"
    end
  end

  get "/tweets/:id/edit" do
    if session[:id] != nil
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to "/login"
    end
  end

  patch "/tweets/:id/edit" do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(:content => params[:content], :user_id => params[:user_id])
      redirect to "/tweets"
    end
  end

  get "/tweets/:id" do
    if session[:id] != nil
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  delete "/tweets/:id/delete" do
    @tweet = Tweet.find(params[:id])
    if params[:delete] != nil
      if @tweet.user_id == session[:id]
        @tweet.delete
        redirect to "/tweets"
      else
        redirect to "/tweets"
      end
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

  post "/tweets" do
    if params[:tweet][:content].empty?
      redirect to "/tweets/new"
    else
      Tweet.create(params[:tweet])
      redirect to "/tweets"
    end
  end

  get "/tweets" do
    if session[:id] != nil
      @user = User.find(session[:id])
      @users = User.all
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/tweets'
  end


  get '/' do
    erb :index
  end

  post '/' do
    if params["sign up"] == "sign up"
      redirect to "/signup"
    else
      redirect to "/login"
    end
  end
end