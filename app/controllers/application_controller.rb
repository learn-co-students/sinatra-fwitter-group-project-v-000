require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/failure' do
    erb :failure
  end

#  get '/signup' do
#    if session[:user_id]
#      redirect "/#{user.slug}"
#    else
#      erb :'/users/create_user'
#    end
#  end

#  post '/signup' do
#    user = User.new(params[:user])
#    if user.save && user.username != nil && user.username != ""
#      session[:user_id] = user.id
#      redirect "/#{user.slug}/tweets"
#    else
#      redirect '/signup'
#    end
#  end

#  get '/login' do
#    if session[:user_id]
#      redirect "/#{user.slug}/tweets"
#    else
#      erb :'/users/login'
#    end
#  end

#  post '/login' do
#    user = User.find_by(username: params[:user][:username])
#    if user && user.authenticate(params[:user][:password])
#      session[:user_id] = user.id
#      redirect "/#{user.slug}/tweets"
#    else
#      redirect '/login'
#    end
#  end

#  get '/:slug/tweets' do
#    @user = User.find(session[:user_id])
#    @tweets = Tweet.all
#    if logged_in?
#      erb :'/tweets/index'
#    else
#      redirect '/failure'
#    end
#  end



#  get '/:slug/tweets/new' do
#    user = User.find(session[:user_id])
#    if logged_in?
#      erb :'/tweets/create_tweet'
#    else
#      redirect '/failure'
#    end
#  end

#  post '/tweets' do
#    @user = User.find(session[:user_id])
#    tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
#    if tweet.save && tweet.content != nil && tweet.content != ""
#      redirect "/#{@user.slug}/tweets" #redirect to tweet show page
#    end
#  end

#  get '/:slug' do
#    @user = User.find(session[:user_id])
#    if logged_in?
#      erb :'/users/show'
#    else
#      redirect '/failure'
#    end
#  end


  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
