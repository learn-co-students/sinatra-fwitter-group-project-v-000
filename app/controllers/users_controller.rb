class UsersController < ApplicationController


    get '/users/index' do
       #render user's homepage view
       @user = User.find(session[:id])
        erb :'/users/index'
    end

end
