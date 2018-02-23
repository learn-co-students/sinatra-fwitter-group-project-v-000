require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"

    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # load the home page
  get '/' do
    erb :'/index'
  end

  # load the create tweet form
  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end
  # process the form submission (new tweet)
  post '/tweets' do
    @tweet = Tweet.create(params[:tweet])
    redirect to '/tweets/#{@tweet.id}'
  end
  # displays the information for a single tweet
  get '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    erb :'/tweets/show_tweet'
  end
  # one to load the form to edit a tweet
  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])
    erb :'/tweets/edit_tweet'
  end
  # update the tweet entry in the database
  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(params[:tweet])
    redirect to "/tweets/#{@tweet.id}"
  end
  # delete a tweet
  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    redirect to '/tweets'
  end
  # display the user signup
  get '/signup' do
    erb :'/users/create_user'
  end
  # process the form submission of user signup
  post '/signup' do
    @user = User.create(params[:user])
    session[:id] = @user.id
    redirect to "/#{@user.slug}/tweets"
  end

  get '/:slug/tweets' do
      @user = User.find_by_slug(params[:slug])
      erb :'/tweets/tweets'
  end

  # display the form to log in
  get '/login' do
    erb :'/users/login'
  end

  # log add the `user_id` to the sessions hash
  post '/login' do
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect to "/#{@user.slug}/tweets"
  end

# logout the user
  get '/logout' do
    session.clear
    erb :'/'
  end
end
