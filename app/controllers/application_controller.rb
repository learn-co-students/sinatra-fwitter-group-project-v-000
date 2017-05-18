require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    
    if !session[:user_id]
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end
  end


  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
    
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])         
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
    
  end
  
  get '/tweets' do    
    
    if session[:user_id]
      @tweets = Tweet.all 
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

   get "/login" do
    if session[:user_id]
      redirect "/tweets"
    else
      erb :'users/login'
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])      
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/logout" do
    if session[:user_id]
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  get '/users/:slug' do
    erb :'tweets/show_tweet'
  end

  get '/tweets/new' do
    if session[:user_id]
      erb :'tweets/create_tweet'
    else
      redirect "/login"
    end
  
  end

  post '/tweets/new' do
    if params[:content] == ""
      redirect "tweets/new"
    else
      @tweet = Tweet.create(:content => params[:content])
      @tweet.user_id = session[:user_id]
      @tweet.save
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      @user = User.find(@tweet.user_id)
      
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end

  end

   get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      @user = User.find(@tweet.user_id)
      erb :'tweets/edit_tweet'
    else
      
      redirect "/login"
    end

  end

  patch '/tweets/:id' do      
      @tweet =  Tweet.find_by_id(params[:id])
      if params[:content] == ""
        
        redirect to("/tweets/#{@tweet.id}/edit")
      else
        @tweet.update(:content=>params[:content])        
        @tweet.save

        redirect to("/tweets/#{@tweet.id}")
      end
  end

  delete '/tweets/:id/delete' do #delete action
     binding.pry
     @tweet = Tweet.find_by_id(params[:id])
     if session[:user_id] == @tweet.user_id      
      @tweet.delete
      redirect to '/tweets'
     else

      redirect to '/login'
     end   

  end



end