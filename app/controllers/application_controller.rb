require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, 'fwitter_secret'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  delete 'tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.delete
    redirect to '/tweets'
  end


  helpers do
    def current_user
      User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

  end

end
