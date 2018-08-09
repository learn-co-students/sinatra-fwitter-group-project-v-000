require './app/helpers/helpers'
class UsersController < ApplicationController

    get "/login" do
        erb :index
      end
    
      get "/signup" do
        #binding.pry
        if Helpers.is_logged_in?(session)
          redirect to './tweets'
        end
          erb :'/users/new'
      end
    
      post "/signup" do
        if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
          user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
          user.save
          session[:user_id] = user.id
        else 
          redirect to '/signup'
        end
        redirect to './tweets'
      end
      
    
      get '/account' do
        @user = User.find(session[:user_id])
        erb :account
      end
    
    
      get "/login" do
        erb :login
      end
    
      post "/login" do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
          @user = user
          session[:user_id] = user.id
          redirect "/account"
        else
          redirect "/failure"
        end
      end
      
      get "/deposit" do
        @user = User.find(session[:user_id])
        erb :deposit
      end
    
      get "/withdrawal" do    
        @user = User.find_by(:id => session[:user_id])
        erb :withdrawal
      end
    
      post "/deposit" do
        @user = User.find(session[:user_id])
        @user[:balance]+= params[:deposit].to_f
        User.update(session[:user_id], :balance => @user[:balance])
        redirect "/account"
      end
    
      post "/withdrawal" do    
        @user = User.find(session[:user_id])
        if @user[:balance] > params[:withdrawal].to_f
          @user[:balance]-= params[:withdrawal].to_f
          User.update(session[:user_id], :balance => @user[:balance])
          redirect "/account" 
        else
           @message = "You have insufficient funds to cover that withdrawal"
           puts @message
           redirect "/account"
        end
      end
    
      get "/failure" do
        erb :failure
      end
    
      get "/logout" do
        session.clear
        redirect "/"
      end
    
end
