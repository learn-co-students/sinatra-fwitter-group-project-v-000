class UsersController < ApplicationController

  configure do
  enable :sessions
  set :session_secret, "secret"
   end


   get '/signup' do  # render sign up page
   erb :'users/signup'
   end


     post '/users' do
       @user = User.new(name: params["name"],
               email: params["email"],
               password: params["password"])
           #then it saved and giving an ID.
       @user.save
       session[:id] = @user.id
       redirect '/users/show'  # this is in another folder
     end



end
