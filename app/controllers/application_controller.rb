require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :'/index'
  end

  get '/tweets/new' do
    #load create tweet form
    # if logged_in?
    #   erb :'/tweets/create_tweet'
    # else
    #   redirect "/"
    # end
    erb :'/tweets/create_tweet'
  end

  get '/tweets/:id' do
    #individual show tweet page
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
  end

  post '/tweets' do
    #submit and catch the data and create new tweet object
    #redirect to individual tweet page
    @tweet = Tweet.create(content: params[:content])
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id/edit' do
    #load form to edit tweet
    #find specific tweet from params[:id] to preload form
    erb :'/tweets/edit_tweet'
  end

  post '/tweets/:id' do
    #catch the data for an edited tweet
    #redirect to tweet show page
    #update
    redirect '/tweets/show_tweets'
  end

  post '/tweets/:id/delete' do
    #delete tweet by :id
    erb :'/index'
  end

  get '/signup' do
    erb '/users/create_user'
  end

  post '/signup' do
    #needs to create new user object
    #log user in with sessions hash
    redirect '/login'
  end

  get '/login' do
    #render login form

    erb :'/users/login'
  end

  post '/login' do
    #add user_id to session hash to login

    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    erb :'/index'
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
