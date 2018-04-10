require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  get '/tweets/new' do
    #load create tweet form
    erb :create_tweet
  end

  get '/tweets/:id' do
    #individual show tweet page
    #
    erb :show_tweet
  end

  post '/tweets' do
    #submit and catch the data and create new tweet objects
    #redirect to individual tweet page
  end

  get '/tweets/:id/edit' do
    #load form to edit tweet
    #find specific tweet from params[:id] to preload form
    erb :edit_tweet
  end

  post '/tweets/:id' do
    #catch the data for an edited tweet
    #redirect to tweet show page
  end

  post '/tweets/:id/delete' do
    #delete tweet by :id
  end














end
