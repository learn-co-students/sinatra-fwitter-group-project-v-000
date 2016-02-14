require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    @session = session
    @tweets = Tweet.all
    erb :index
  end

  ################### users ###################
  get '/signup' do
    redirect to '/tweets' if Helpers.is_logged_in?(session)
    erb :'users/create_user'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    end
    # create new user
    user = User.new(
      username: params[:username],
      email: params[:email],
      password: params[:password]
    )
    if user.save
      session[:id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    redirect to '/tweets' if Helpers.is_logged_in?(session)
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:id] = user.id
        redirect '/tweets'
    else
        redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end


  ################ tweets ################
  get '/tweets' do
    redirect to '/login' unless Helpers.is_logged_in?(session)
    @user = User.find(session[:id])
    @session = session
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    redirect to '/login' unless Helpers.is_logged_in?(session)
    @session = session
    @user = User.find(session[:id])
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    user = User.find(session[:id])
    if Tweet.create(content: params[:content].chomp).valid?
      user.tweets << Tweet.all.last
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    redirect to '/login' unless Helpers.is_logged_in?(session)
    @session = session
    @user = User.find(session[:id])
    @tweet = Tweet.find_by(id: params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    redirect to '/login' unless Helpers.is_logged_in?(session)
    @session = session
    @user = User.find(session[:id])
    @tweet = Tweet.find_by(id: params[:id])
    erb :'tweets/edit_tweet'
  end

  post '/tweets/:id' do
    tweet = Tweet.find_by(id: params[:id])
    tweet.update(content: params[:content])
    if tweet.errors
      redirect "/tweets/#{tweet.id}/edit"
    else
      redirect "/tweets/#{tweet.id}"
    end
  end

  post '/tweets/:id/delete' do
    redirect to '/login' unless Helpers.is_logged_in?(session)
    begin
      tweet = Helpers.current_user(session).tweets.find(params[:id])
      tweet.destroy
      redirect '/tweets'
    rescue ActiveRecord::RecordNotFound
      redirect '/tweets'
    end
  end


  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/tweets'
  end



end


class Helpers
  def self.current_user(session)
    User.find(session[:id])
  end

  def self.is_logged_in?(session)
    session[:id] != nil && !!self.current_user(session)
  end
end
