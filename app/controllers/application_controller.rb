require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  configure do
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do 
    erb :index
  end 
  
  get '/signup' do 
    #binding.pry
    if session[:user_id] != nil
      redirect "/tweets"
    end 
    erb :signup 
  end 
  
  get '/login' do 

    if session[:user_id] != nil
      redirect "/tweets"
    end
    
    erb :login 
  end 

  get '/tweets' do
    #binding.pry
    if session[:user_id] != nil 
      @user = User.find(session[:user_id])
      erb :show
      
      #redirect "/users/#{@user.id}"
    else 
      redirect '/login'
    end 
  end 
  
  get '/tweets/new' do 
    if session[:user_id] != nil 
      @user = User.find(session[:user_id])
      erb :new
      
      #redirect "/users/#{@user.id}"
    else 
      redirect '/login'
    end 
  end 
  
  get '/tweets/:id' do
    #binding.pry
    
    if session[:user_id] != nil 
      @tweet = Tweet.find(params["id"])
      erb :tweet 
    else 
      redirect '/login'
    end 
  end 
  
  get '/tweets/:id/edit' do 
    if session[:user_id] != nil 
      @tweet = Tweet.find(params["id"])
      erb :edit 
    else 
      redirect '/login'
    end 
  end 
  
  get '/users/:id' do 
    @user = User.find(session[:user_id])
    erb :show 
  end 
  
  get '/logout' do 
    
    if session[:user_id] != nil 
      session.clear 
      erb :logout 
    end

    redirect '/login'
  end 
  
  delete'/delete/:id' do 
    #binding.pry
    if session[:user_id] == params["id"].to_i
      @tweet = Tweet.delete(params["id"])
      redirect '/'
    else 
      redirect '/tweets'
    end 
  end 

  post '/tweets' do 
    #binding.pry
    @tweet = Tweet.create(:content => params["tweet"])
    if @tweet.content == ""
      Tweet.last.delete 
      redirect '/tweets/new'
    else 
      @tweet.save 
      @user = User.find(session[:user_id])
      @user.tweets << @tweet 
      redirect '/tweets'
    end 
  end
  
  patch '/tweets/:id' do 
    
    @tweet = Tweet.find(params["id"])
   
    if params["content"] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    else 
      @tweet.content = params["content"]
      @tweet.save 
      redirect "/tweets/#{@tweet.id}"
    end 
  end 

  post '/logout' do
    binding.pry
    session.clear 
    redirect '/login'
  end 

  post '/login' do 
    @user = User.find_by(:username => params["username"])
    if @user && @user.authenticate(params["password"])
      #binding.pry
      session[:user_id] = @user.id 
      redirect '/tweets'
    else
      binding.pry
      redirect '/login'
    end 
  end 
  
  post '/signup' do 
    @user = User.create(params)
    #binding.pry
    @user.attributes.each do |att|
      if att[1] == "" || att[1] == nil
        redirect "/signup"
      end 
    end 
    
    session[:user_id] = @user.id 
    
    redirect "/tweets"
  end 
  

end