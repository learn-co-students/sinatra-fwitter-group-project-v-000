class UsersController < ApplicationController


    get '/signup' do
      if !logged_in?
        erb :'/users/create_user'
        flash[:message] = "Welcome to Fwitter! Please sign up."
      else
        redirect to '/tweets'
     end
   end


    # get '/users/new' do
    #   @user = User.all
    #   params hash {key/value pair user is new 11 user must register also
    #   know as "signing up" }
    # #     erb :'user/login' || 'user/signup'
    # end



    # post '/users' do
    #   redirect
    #   erb :
    # end
    #
    #
    # get '/users/:id' do
    #   if !logged_in?
    #     erb :
    # end
    #
    #
    # get '/users/:id/edit' do
    #   if !logged_in?
    #     erb :
    # end
    #
    #
    # patch 'users/:id' do
    # end
    #   erb :
    #
    #
    # put '/users/:id' do
    #   erb :
    # end
    #
    #
    # delete '/users/:id' do
    #   erb :
    # end

end
