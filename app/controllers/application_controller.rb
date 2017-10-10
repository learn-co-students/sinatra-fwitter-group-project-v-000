require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def all_emails
      User.all.collect {|user| user.email.downcase}
    end

    def all_usernames
      User.all.collect {|user| user.username.downcase}
    end

  end

  get '/' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'/index'
    end
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/signup'
    end
  end

  post '/signup' do
    if (all_usernames.include?(params["username"].downcase)) || (all_emails.include?(params["email"].downcase))
      redirect "/invalid-signup"
    elsif (!params["username"].empty?) &&  (!params["email"].empty?) &&  (!params["password"].empty?)
      @user = User.create(:username=>params[:username], :email=>params[:email], :password=>params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/invalid-signup' do
    erb :'/invalid-signup'
  end

  post '/invalid-signup' do
    if (all_usernames.include?(params["username"].downcase)) || (all_emails.include?(params["email"].downcase))
      redirect "/invalid-signup"
    elsif (!params["username"].empty?) &&  (!params["email"].empty?) &&  (!params["password"].empty?)
      @user = User.create(:username=>params[:username], :email=>params[:email], :password=>params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/users/:slug' do
    #if !logged_in?
    #  redirect '/login'
    #end
    @user=User.find_by_slug(params[:slug])
    if !@user
      redirect '/failure'
    else
      erb :'/users/show'
    end

  end

  get '/tweets' do
    if logged_in?
      erb :'/tweets/index'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      if @tweet = Tweet.find_by_id(params[:id])

        erb :'/tweets/show'
      else
        redirect '/failure'
      end
    else
      redirect "/login"
    end

  end

  post '/tweets' do
    if !params[:content].empty?
      @user = User.find(session[:user_id])
      @tweet = Tweet.create(content: params[:content])
      @user.tweets << @tweet
      #binding.pry
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweet= Tweet.find_by(id: params[:id])
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet= Tweet.find_by(id: params[:id])
    if params["content"].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params["content"])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet= Tweet.find_by(id: params[:id])
    if logged_in? && (@tweet.user_id = session[:user_id])
      @tweet.delete
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/login'
    end
  end

  post '/login' do
    @user=User.find_by(:username=>params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id]=@user.id
      redirect "/tweets"
    else
      redirect "/invalid-login"
    end
  end

  get '/invalid-login' do
    erb :'/invalid-login'
  end

  post '/invalid-login' do
    @user=User.find_by(:username=>params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id]=@user.id
      redirect "/tweets"
    else
      redirect "/invalid-login"
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  get '/failure' do
    erb :'/failure'
  end

end
