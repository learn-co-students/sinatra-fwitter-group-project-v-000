require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end
################ homepage ####################
  get '/' do
    erb :index
  end
  ############# signup ########################

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(params)
    @user.save
    #binding.pry
    session[:user_id] = @user.id
     if logged_in?
       redirect '/tweets'
     else
       redirect '/signup'
     end
  end

  ############# login ###########################

  get '/login' do
     if logged_in?
       redirect '/tweets'
     else
      erb :'users/login'
     end
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    session[:user_id] = @user.id
    if logged_in?
      redirect '/tweets'
    else
      redirect '/login'
    end

  end

############## logout ##################


  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  ########### tweets #####################3

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
    erb :'tweets/tweets'
    #binding.pry
  else
    redirect '/login'
  end

  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect "/tweets/new"
    else
    @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
    @tweet.save
    end
    #binding.pry
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/edit_tweet"
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if current_user.id == @tweet.user_id
    @tweet.destroy
    end
  end

  post '/tweets/:id' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
    @tweet = Tweet.find(params[:id])
    @tweet.update(params)
    #binding.pry
    end
  end

  ############## users ################

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
    #binding.pry
  end

  ################## helpers #################

  helpers do
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end
end

end
