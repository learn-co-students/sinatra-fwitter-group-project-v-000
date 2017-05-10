require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "fwitter"
  end

  get '/' do

    erb :index
  end

  get '/signup' do
    redirect("/tweets") if logged_in?(session)

    erb :signup
  end
  
  post '/signup' do
    @user = User.new(params)

    if @user.save
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
    
  end
  
  helpers do
    def logged_in?(session)
      !!session[:id]
    end
    
    def current_user(session)
      User.find(session)
    end
    
  end

  


end