require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end


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
    if params[:username].empty?||params[:email].empty?||params[:password].empty?
      puts "Please fill all the fields"
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    end

    session[:id] = @user.id
    #redirect to user's  twitter index
    redirect to '/tweets'
  end


  #--------------------LOGIN----------------------------

  get '/login' do
    #login form to post to post '/login'
    erb :'sessions/login'
  end

  post '/login' do
    #finds the user by params and redirects to the newsfeed aka index
    if !!params[:email]
      @user = User.find_by(email: params[:email], password: params[:password])
    else !! params[:username]
      @user = User.find_by(username: params[:username], password: params[:password])
    end

    session[:id] = @user.id

    redirect to "/tweets"
  end

  get '/user_id/homepage' do
    #navigates to user's homepage
    erb :'sessions/homepage'
  end

 #----------------------LOGOUT--------------------
 get '/logout' do
   #clear session
   session.clear
   #redirect to homepage
   redirect to '/'
 end
  #-------------CREATE A TWEET -------------

  get '/tweet/new' do
    #form to create a new tweet and post to post '/tweets'
    erb :new
  end

  post '/tweets' do
    #creates new tweet and redirects to '/tweets/#{@tweet.id}'
    # redirect to "/tweets/#{@tweet.id}"
  end

  #---------------SHOW TWEET ---------------

  get '/tweets/:id' do
    #finds a tweet by id and shows
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  end

  get '/tweets' do
    erb :'tweets/index'
  end

  #---------------EDIT A TWEET -------------

  get '/tweets/:id/edit' do
    #finds a tweet by id
    #directs to a form for inputs
    #sends params from form to the patch path
    erb :edit
  end

  patch '/tweets/:id' do
    #gets params from the form
    #updates the tweets
    #redirects to the show page
    redirect to "/tweets/#{@tweet.id}"
  end

  #---------------DELETE A TWEET----------------

  get '/tweets/:id/delete' do
    #link present alongside each tweet
    #hits the delete path

  end

  delete '/tweets/:id' do
    #finds the tweet and deletes it
    @tweet = Tweet.find(params[:id])
    @tweet.destroy

    #redirects to user's full list of tweets?
  end

  #--------------------HELPER METHODS-------------
  #a user should not be able to edit or delete the tweets created by a different user
  #a user can only modify their own tweets.

  helpers do

    def current_user


    end

    def logged_in?
    #  !!current_user? true: false
    end

  end



end
