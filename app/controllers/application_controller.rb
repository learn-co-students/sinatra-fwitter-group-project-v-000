require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do 

    erb :'/index'
  end

  get '/signup' do 
    redirect '/tweets'if logged_in?
    erb :'/users/create_user'
  end


  get '/login' do 
    redirect '/tweets'if logged_in?
    erb :'/users/login'

  end

  get '/users/:slug' do 

    @user = User.find_by_slug(params[:slug])
 
    @tweets = @user.tweets

    erb :'/users/show'
  end

  post '/signup' do 


      if params[:username] == "" 
        redirect '/signup'
      elsif params[:password] == ""
        redirect '/signup'
      elsif params[:email] == ""
        redirect '/signup'
      else
        @user = User.create(username: params[:username], password: params[:password], email: params[:email])
        if @user.save
          session[:user_id] = @user.id
          redirect '/tweets'
        else
          redirect '/signin'
        end
      end
    
  end


  

  get '/login' do 

    erb :'/users/login'
  end

  post '/login' do 
    @user = User.find_by(username:  params[:username])
    if params[:username] == "" || params[:password] == ""
      redirect '/login'
    elsif @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id 
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets' do

    redirect '/login' if !logged_in?

    @user = User.find(session[:user_id])
    @tweets = @user.tweets
    @all_tweets = Tweet.all


    erb :'/tweets/tweets'
  end

  get '/tweets/new' do 

    redirect '/login' if !logged_in?
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do 
    redirect '/login' if !logged_in?
    redirect '/tweets/new' if params[:content] == ""
    @user = User.find(session[:user_id])
    @user.tweets<<Tweet.create(content: params[:content], user_id: @user.id)



    redirect "/tweets/#{@user.tweets.last.id}"

  end

  get '/tweets/:id' do 
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do 
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])


    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    redirect '/login' if !logged_in?
    redirect "/tweets/#{@tweet.id}/edit" if params[:content] == ""
    @tweet.update(content: params[:content])
    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    redirect '/login' if !logged_in?

    redirect '/tweets' if session[:user_id] != Tweet.find(params[:id]).user_id
    Tweet.delete(params[:id])
    redirect '/tweets'
  end


  get '/logout' do
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

end