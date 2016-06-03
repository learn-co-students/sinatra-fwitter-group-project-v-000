require './config/environment'

class ApplicationController < Sinatra::Base
   

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :index
  end 



  get '/signup' do

    if session[:id] == nil 
     erb :'users/create_user'
    else 
     redirect '/tweets'
    end 

  end 

  get '/tweets' do 
     if session[:id] != nil 
      @user = User.find_by_id(session[:id])
      erb :'tweets/tweets'
     else
      redirect '/login'
     end 
  end 

  get '/tweets/new' do 
     if session[:id] != nil 
      @user = User.find_by_id(session[:id])
      erb :'tweets/create_tweet'
     else
      redirect '/login'
     end 

  end 

  delete '/tweets/:id/delete' do 
    
       
       if session[:id] != nil
        
         @tweet = Tweet.find_by_id(params[:id])
         if @tweet.id == session[:id]
           @tweet.destroy 
         end 
         redirect '/tweets'
       else 
        redirect '/login'
       end 
  end 


 get '/tweets/:id/edit' do 
    
      if session[:id] != nil 

        @tweet = Tweet.find_by_id(params[:id])
         if @tweet && @tweet.user_id == session[:id] 
          erb :'tweets/edit_tweet'
         else 
          redirect '/tweets'
         end 

      else 
        redirect '/login'
      end 
  end 

  post "/tweets/:id/edit" do 
     
      if session[:id] != nil 

        @tweet = Tweet.find_by_id(params[:id])
        
         if @tweet.user_id == session[:id]
          erb :'tweets/edit_tweet'
         else 
          redirect '/tweets'
         end 

      else 
        redirect '/login'
      end 
  end 


  



    get '/tweets/:id' do 
       
      if session[:id] != nil 
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweet'
      else 
        redirect '/login'
      end 
    end 
  
  get '/login' do 
   if session[:id] == nil  
     erb :'users/login'
   else 
    redirect '/tweets'
   end 
  end 

  get '/logout' do 
    if session[:id] != nil 
      session.clear 
      redirect '/login'
    else 
      redirect "/"

    end 
  end 


   get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'users/users_tweets'
   end 

   post '/signup' do
    
     if params[:username] != "" && params[:password] != "" && params[:email] != ""
      
      @user = User.create(:username => params[:username]) 
      @user.email = params[:email]
      @user.password_digest = params[:password]
      @user.save 
      session[:id] = @user.id
      redirect '/tweets'

      else 
       redirect '/signup'
      end 

    end 

  
  post '/login' do 
   
   @user = User.find_by(username: params[:username]) 
    
     if @user && @user.authenticate(params[:password])
        session[:id] = @user.id 
        redirect '/tweets'
     else 
        redirect '/login'

     end 
   end 

   post '/tweets/new' do 
    
     @user = User.find_by_id(session[:id])
     
      if params[:content] != ""
       
        @user.tweets << Tweet.create(:content => params[:content])
        redirect '/tweets'
      end 
   end 

    patch '/tweets/:id' do 
      if params[:content] != ''
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save 
        redirect '/tweets'
      else 
         redirect "/tweets/#{params[:id]}/edit"
      end 
    end 





end














