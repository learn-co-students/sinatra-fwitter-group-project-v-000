require './config/environment'
require 'pry'
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
        User.find(session[:user_id])
    end
end
    
    get '/' do 
        if logged_in?
            redirect '/tweets'
        else
            erb :index
      end
    end
    
    get '/signup' do 
        if logged_in?
            redirect to '/tweets'
        else
            erb :'/users/create_user'
        end
    end
    
    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        else
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            @user.save 
            session[:user_id] = @user.id
            redirect to '/tweets'
        end
    end
    
    get '/login' do 
        if logged_in?
            redirect to :'/tweets'
        else
            erb :'/users/login'
            
        end
    end
    
    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect :'/tweets'
        else
            erb :'/users/create_user'
        end
    end
    
       get '/logout' do 
           if logged_in?
            session.clear
            redirect to '/login'
           else
            redirect to '/'
           end
               
       end
    
       get '/users/:slug' do 
           @user = User.find_by_slug(params[:slug])
           erb :'/users/show'
       end
    
       get '/tweets' do 
        if logged_in?
            @user = current_user
            erb :'/tweets/tweets'
        else
            redirect to '/login'   
        end
    end
    
    get '/tweets/new' do 
        if logged_in?
            erb :'/tweets/create_tweet'
        else
            redirect to '/login'
        end
    end
    
    post'/tweets' do
        if !params[:content].empty?
        @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
        @tweet.save
        @tweet.save
            redirect to '/tweets' 
        else
            redirect to '/tweets/new'
        end
    end
    
    get '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find(params[:id])
            @user = User.find(@tweet.user_id)
            erb :'tweets/show_tweet'
        else
            redirect to '/login'
        end
    end
    
    delete '/tweets/:id/delete' do 
        @user = current_user
        @tweet = Tweet.find(params[:id])
        if @user.id == @tweet.user_id
            @tweet.delete 
            redirect to '/tweets' 
        else
            redirect to '/tweets'
        end
    end
    
    get '/tweets/:id/edit' do
        if logged_in?
        @tweet = Tweet.find(params[:id])
        @user = User.find(@tweet.user_id) 
            erb :'tweets/edit_tweet'
        else
            redirect to '/login'
        end
    end
    
    patch '/tweets/:id' do 
        @tweet = Tweet.find(params[:id])
        @user = current_user
        if params[:content] != "" && @user.id == @tweet.user.id
            @tweet.update(content: params[:content])
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to "/tweets/#{@tweet.id}/edit"
        end
    end
            
        


end