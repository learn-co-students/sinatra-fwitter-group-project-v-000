require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb "/index"
  end

  get '/tweets/new' do
    #load create tweet form
    erb '/tweets/create_tweet'
  end

  get '/tweets/:id' do
    #individual show tweet page
    #
    erb '/tweets/show_tweet'
  end

  post '/tweets' do
    #submit and catch the data and create new tweet objects
    #redirect to individual tweet page
    redirect '/tweets/:id'
  end

  get '/tweets/:id/edit' do
    #load form to edit tweet
    #find specific tweet from params[:id] to preload form
    erb '/tweets/edit_tweet'
  end

  post '/tweets/:id' do
    #catch the data for an edited tweet
    #redirect to tweet show page
    #update
    redirect '/tweets/show_tweets'
  end

  post '/tweets/:id/delete' do
    #delete tweet by :id
    erb '/index'
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
    erb '/users/login'
  end

  post '/login' do
    #add user_id to session hash to login
    erb '/users/show'
  end
end
