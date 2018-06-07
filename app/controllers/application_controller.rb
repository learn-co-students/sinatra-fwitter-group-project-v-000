require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end
  
  
  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
       if logged_in?
          @current_user = User.find_by(id: session[:user_id])
        end
      end
    end 
  
  
  
get '/' do 
    erb :index 
end 
  
  
   #TWEET CONTROLLER 
   
   
get '/tweets' do
  if logged_in?
    @user = User.find(session[:user_id])
    @tweets = Tweet.all 
    erb :'tweets/tweets'
  else 
    redirect '/login'
  end
end 

    
   
get '/tweets/new' do
  if logged_in?
  erb :'/tweets/create_tweet' 
 else 
  redirect '/login'
 end 
end


post '/tweets' do 
  if !params[:content].empty?
    user = User.find_by_id(session[:user_id])
    @tweet = Tweet.create(content: params[:content], :user_id => user.id)
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  else
    redirect '/tweets/new'
 end 
end 



get '/tweets/:id' do
  if logged_in?
  @tweet= Tweet.find(params[:id])
  erb :'tweets/show_tweet' 
else
   redirect '/login'
 end 
end 

get '/tweets/:id/edit' do
  if logged_in?
  @tweet =Tweet.find(params[:id])
  erb :'tweets/edit_tweet'
else 
  redirect '/login'
  end 
end 


delete '/tweets/:id/delete' do
  if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == current_user.id
    @tweet.destroy 
  end 
  elsif !logged_in?
    redirect '/login'
  else
    redirect  "/tweets/#{@tweet.id}"
  end 
end 

patch '/tweets/:id' do
   @tweet = Tweet.find_by_id(params[:id])
    if  !params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save 
    redirect "/tweets/#{@tweet.id}"
else 
    redirect "/tweets/#{@tweet.id}/edit"
 end
end 


  #USERSCONTROLLER
  
  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else 
      redirect '/tweets'
    end 
  end 
  
  post '/signup' do 
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
    redirect '/signup'
  else
    @user = User.create(username: params[:username], password: params[:password], email: params[:email])
    @user.save 
    session[:user_id] = @user.id
    redirect '/tweets'
  end 
end 


  
 get '/login' do  
   if logged_in?
     redirect '/tweets'
   else 
  erb :'users/login'
  end 
end 



post '/login' do
 
    user = User.find_by(:username => params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/tweets'
  else 
    redirect '/login'
  end
end 

get '/users/:slug' do
   @user = User.find_by_slug(params[:slug])
  erb :'users/show'
  end


get '/logout' do
 if logged_in?
   session.destroy
   redirect '/login'
 else 
   redirect '/login'
 end
end 
 
 

end 

