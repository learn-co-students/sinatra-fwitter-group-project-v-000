class UsersController < ApplicationController

    #-----------------HOMEPAGE---------------

    get '/' do
      #welcomes the user
      #sign up link
      #login link
      erb :index
    end

    #------------------SIGNUP-------------------

    get '/signup' do
      #sign up form sent to post to post '/signup'
      erb :'registrations/signup'
    end

    post '/signup' do
      #creates the user
      #log the user in
      #add user_id to session hash
      if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect to '/signup'
      else
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      end

      session[:id] = @user.id
      redirect to '/tweets'

    end


    #--------------------LOGIN----------------------------

    get '/login' do
      #login form to post to post '/login'
      erb :'sessions/login'
    end

    post '/login' do
      #finds the user by params and redirects to the newsfeed aka index
        @user = User.find_by(username: params[:username], password: params[:password])
        session[:id] = @user.id
        redirect to "/tweets"
      end

    # get '/user_id/homepage' do
    #   #navigates to user's homepage
    #   erb :'sessions/homepage'
    # end

   #----------------------LOGOUT--------------------
   get '/logout' do
     #clear session
     session.clear
     #redirect to homepage
     redirect to '/'
   end

    #--------------------HELPER METHODS-------------
    #a user should not be able to edit or delete the tweets created by a different user
    #a user can only modify their own tweets.

    helpers do

      def current_user
        @user = User.find(session[:id])
        @user
      end

      def logged_in?
        !!session[:id]? true: false
      end

    end


end
