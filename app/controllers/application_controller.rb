require './config/environment'


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :layout
  end

  get '/signup' do 
    erb :'users/create_user'
  end

  post '/signup' do 
    @user = User.new
    @user.name = params[:username]
    @user.password = params[:password]
    @user.email = params[:email]
    @user.save
    erb :'/users'
  end

  get '/tweets/new' do 
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do 
    @tweet = Tweet.create(params[:tweet])
    erb :tweets
  end

  get '/tweets' do 
    ## this shows the info for a single tweet 
  end

  get '/tweets/:id/edit' do 
    ## this is part of the edit, and contains the form to edit
  end

  post '/tweets/:id' do 
    ## this is part of the edit, and actually posts the update
  end 

  post '/tweets/:id/delete' do
    ## this deletes the tweet. the delete button should be on the show page
  end

  get '/logout' do 
    ## logout the user. This should clear the session hash
  end

  ## need to create two helper methods current_user and is_logged_in

  def self.current_user(session)
   @user = User.find_by_id(session["user_id"])
  end
 
  def self.is_logged_in?(session)
    !!current_user(session)
  end




end ## class end 















