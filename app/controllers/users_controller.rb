require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash, :sweep => true

    #------------------SIGNUP-------------------

    get '/signup' do
      if Helpers.logged_in?(session)
        redirect to '/tweets'
      else
        erb :'registrations/signup'
      end
    end

    post '/signup' do
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
      if Helpers.logged_in?(session)
        redirect to "/tweets"
      else
        erb :'sessions/login'
      end
    end

    post '/login' do
      user = User.find_by(username: params[:username])

      if user && user.authenticate(params[:password])
        session[:id] = user.id
        redirect to '/tweets'
      elsif !!params[:password].empty?
        flash[:message] = "Please enter your password"
        redirect to '/login'
      elsif !!params[:username].empty?
        flash[:message] = "Please enter your username"
        redirect to '/login'
      else
        flash[:message] = "Invalid information. Please try again."
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
