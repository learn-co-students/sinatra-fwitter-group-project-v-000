require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

  get '/' do 
    erb :index
  end

  get '/tweets/new' do 
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do 
    @tweet = Tweet.create(params[:tweet])
    erb :tweets
  end

  #CREATE SESSIONS

  def self.current_user(session)
   @user = User.find_by_id(session['user_id'])
  end
 
  def self.is_logged_in?(session)
    !!current_user(session)
  end

end
