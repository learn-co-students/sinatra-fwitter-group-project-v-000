require './config/environment'


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :index
  end

  get '/signup' do 
    if logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      @user = User.create(name: params[:username], password: params[:password], email: params[:email])
      session[:id] = @user.id
      redirect '/tweets'
    end
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

  helpers do 
    def current_user(session)
     User.find(session[:id])
    end
 
    def logged_in?(session)
     !!session[:id]
    end
  end




end ## class end 















