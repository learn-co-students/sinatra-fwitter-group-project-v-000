require './config/environment'

class ApplicationController < Sinatra::Base
 register Sinatra::ActiveRecordExtension
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "bing bong"
  end

  get '/' do
    erb :index
  end  

  get '/users' do 
    @users = User.all
    erb :'artists/index'
  end

   get '/users/create_user' do
    erb :'users/create_user'
  end

  # get '/users/:slug' do 
  #   @artist = User.find_by_slug(params[:slug])
  #   erb :'users/show_tweets' 
  # end
   
 

   get '/users/login' do
    erb :'users/login'
  end


  post '/users/login' do #-- login page
    @user = User.find_by(:username => params[:username])
    if @user != nil && @user.password == params[:username] 
      session[:user_id] = @user.id
      redirect to 'user/tweets'
    end
    erb :error
  end

  post '/users/create_user' do
     if params[:username] == "" || params[:password] == ""
      redirect "error"
    else
      redirect '/index'
    end
  end

  get '/logout' do#-- logout takes back to home
    session.clear
    redirect to '/'
  end

  get '/users/home' do
    @user = User.find(session[:id])
  erb :'/users/home'
  end

  get '/tweets' do
    @tweets = Tweet.all 
    erb :'/tweets/tweets'
    end

  get '/tweets/new' do 
    erb :'tweets/new'
  end

  get '/tweets/:id' do
    # binding.pry
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show_tweets'
  end

  post '/tweets' do
    @tweets = Tweet.create(content: params[:content])
    redirect "/tweets/#{tweet.id}"
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:name]
    @tweet.save
    erb :'/tweets/show_tweets'
  end




  


  





  
end