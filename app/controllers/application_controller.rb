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

  get '/logout' do
    session.clear
    redirect to '/'
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
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

  patch '/tweets/:id' do
    if params[:content] == "" || params[:content] == nil
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

<<<<<<< HEAD
  delete '/tweets/:id/delete' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
=======


  get '/signup' do
    erb :'/users/create_user'
  end
  post '/signup' do
    binding.pry

>>>>>>> d78bfaca004e2c1a75ba1e8c94ff4c6d91314e74
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
