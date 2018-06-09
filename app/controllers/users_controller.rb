class UsersController < ApplicationController

  configure do
  enable :sessions
  set :session_secret, "secret"
   end

   get '/signup' do
      erb :'users/signup'
    end



   post '/signup' do



     if (params[:username] == "" || params[:email] == "" || params[:password] == "")

       redirect '/signup'

     else   @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])

             if @user.save

           session[:id] = @user.id
            redirect to '/tweets'
          end

     end
            # if @user.save
            #   session[:id] = @user.id
            #   redirect '/tweets'
            # else
            #   redirect '/signup'
            # end
                 #then it saved and giving an ID.
     end


    # >>>>>Log in part<<<
     get '/login' do

		   erb :'/users/login'
    end

      #session goes here.

      post '/users/login' do
                #handles logged in input of user from the params / Match that infor
                # with existing entries in the user database.
           @user = User.find_by(:username => params[:username], :password => params[:password])

             if session[:id] = @user.id

               redirect to '/tweets'   #redirect to tweets controller

            else
              redirect '/login'
            end

     end

       get '/users/logout' do
          # log user out by clearing the session
        session.clear
        redirect '/'
        end


end
