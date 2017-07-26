class UserController < ApplicationController
    get '/users/:slug' do 
      @user = current_user
      @tweets = @user.tweets
      erb :'users/show'
    end
end