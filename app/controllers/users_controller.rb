require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash, :sweep => true

    #------------------SIGNUP-------------------

    get '/signup' do
      #sign up form sent to post to post '/signup'
      if Helpers.logged_in?(session)
        redirect to '/tweets'
      else
        erb :'registrations/signup'
      end
    end

    post '/signup' do
      #creates the user
      #log the user in
      #add user_id to session hash
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      user.save

      if user.save
        session[:id] = user.id
        redirect to '/tweets'
      else
        redirect to '/signup'
      end
    end


    #--------------------LOGIN----------------------------

    get '/login' do
      #login form to post to post '/login'
      if Helpers.logged_in?(session)
        redirect to '/tweets'
      else
        erb :'sessions/login'
      end
    end

    post '/login' do
      #finds the user by params and redirects to the newsfeed aka index
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:id] = user.id
        redirect to '/tweets'
      else
        redirect to '/login'
      end
    end

   #----------------------LOGOUT--------------------
   get '/logout' do
     #clear session
     #redirect to homepage
     if Helpers.logged_in?(session)
       session.clear
     end

     redirect to '/login'
   end

   #----------------------SHOWPAGE--------------------------
   get '/users/:slug' do
     @user = User.find_by_slug(params[:slug])
     @tweets = @user.tweets
     erb :'users/show'
   end

end
