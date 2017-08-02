require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    redirect to '/tweets' if logged_in? 

    erb :'/users/create_user'
  end

  get '/login' do
    redirect to '/tweets' if logged_in?

    erb :'users/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(slug)

    erb :'users/show'
  end

  get '/tweets/new' do
    redirect to '/login' unless logged_in?

    erb :'tweets/create_tweet'
  end

  get '/tweets/:id' do
    redirect to '/login' unless logged_in?

    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    redirect to '/login' unless logged_in?

    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

  get '/tweets' do
    redirect to '/login' unless logged_in?

    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  get '/logout' do
    session.clear if logged_in?

    redirect to '/login'
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end

    flash[:notice] = "Invalid input. Please try again."
    redirect to '/signup'
  end

  post '/login' do
    if @user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    end

    flash[:notice] = "Invalid login. Please try again."
    redirect to '/login'
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content], user_id: current_user.id)

    unless @tweet.save
      flash[:notice] = "Invalid tweet. Please try again."
      redirect to '/tweets/new'
    end

    redirect to "/tweets/#{@tweet.id}"
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    redirect to '/tweets' unless @tweet.user.id == current_user.id

    if params[:content].empty?
      flash[:notice] = "Invalid content. Please try again."
      redirect to "/tweets/#{@tweet.id}/edit"
    elsif @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to '/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.destroy if @tweet.user.id == current_user.id

    redirect to '/tweets'
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