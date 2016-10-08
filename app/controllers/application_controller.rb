require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "Fwitter is secure"
  end

  get '/' do
    erb :index
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] == nil || params[:content] == ""
      redirect to '/tweets/new'
    else
      @tweet = current_user.tweets.create(content: params[:content])
      redirect to '/tweets/#{@tweet.id}'
    end
  end

  helpers do

    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end
