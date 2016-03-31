require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "secret"
  end

# Users Actions
  get '/' do
    erb :index
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)

      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if !(params.any? {|key, userdata| userdata.empty?})
      @user = User.create(params)
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    session[:id] = user.id
    redirect '/tweets'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

#tweets actions
  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = User.find_by_id(session[:id])
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    @tweet = Tweet.create(content: params[:content], user_id: session[:id])
    if @tweet.content ==""
        redirect "/tweets/new"
    else
      redirect "/tweets/#{@tweet.id}"

    end
  end

  post '/tweets' do
    @user = User.find_by_id(params[:id])
    erb :'tweets/tweets'
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweet'
    else
      redirect '/login'
    end

  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    if !(@tweet.content)
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:id]
        @tweet.delete
      else
        redirect '/tweets'
      end
  end


  class Helpers

    def self.current_user(session_info)
      User.find_by_id(session_info[:id])
    end

    def self.is_logged_in?(session_info)
      !!session_info[:id]
    end
  end
end
