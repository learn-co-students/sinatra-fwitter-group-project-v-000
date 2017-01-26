require 'pry'

class UsersController < ApplicationController
    
    get "/users/:slug" do
      @user = User.find_by(params[:slug])
      erb :'users/show'
    end
    
    get '/users' do
      @tweet = Tweet.all
      erb :'users/show'
    end 
    
    
end 