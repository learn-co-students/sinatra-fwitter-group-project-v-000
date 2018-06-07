class UsersController < ApplicationController

  configure do
  enable :sessions
  set :session_secret, "secret"
   end


   get '/signup' do  # render sign up page
       if session[:id]
          redirect :'/users/tweets'
        else


         erb :'/users/signup'
       end

   end


   post '/signup' do
     @user = User.new(:name => params[:username], :email => params[:email], :password => params[:password])


            if @user.save

              session[:id] = @user.id
              redirect "/users/tweets"
            else
              redirect "/users/signup"
            end
                 #then it saved and giving an ID.
     end

     get '/users/login' do
		    erb :'/users/login'
	    end

      #session goes here.

      post '/users/login' do
                #handles logged in input of user from the params / Match that infor
                # with existing entries in the user database.

         @user = User.find_by(email: params["email"], password: params["password"])

         if session[:id] = @user.id

          redirect '/users/tweets'
        else
          redirect '/users/'

        end

     end

       get '/users/logout' do
          # log user out by clearing the session
        session.clear
        redirect '/'
        end


end
