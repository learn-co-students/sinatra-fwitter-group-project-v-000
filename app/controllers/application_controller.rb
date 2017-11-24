require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'user/create_user'
  end

  get '/login' do
    erb :'user/login'
  end

  get '/logout' do
    erb :index
  end

  get '/show' do
    erb :'user/show'
  end

  get '/tweets/new' do

    erb :"tweet/create_tweet"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params['id'])
    erb :"tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params['id'])
    erb :"tweet/edit_tweet"
  end

  post '/signup' do
    user = User.new(:username => params[:username], :password => params[:password])

    if user.save
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/show"
      else
        redirect "/"
      end
       redirect "/show"
    else
       redirect "/signup"
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/show"
    else
      redirect "/"
    end
  end

  post '/tweets' do
    redirect to "tweets/show"
  end

  post '/tweets/:id'do
    @tweet = Tweet.find_by(id: params['id'])
    redirect to "tweets/show"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
