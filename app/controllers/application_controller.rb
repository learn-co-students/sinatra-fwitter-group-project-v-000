require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
  end 
  
  get '/signup' do 
  end 

  get '/login' do 
  end 

  get '/logout' do 
  end 

  get '/tweets' do 
  end 

  get 'tweets/new' do 
  end 

  get '/tweets/:id' do 
  end 

  get '/tweets/:id/edit' do 
  end 

  post '/signup' do 
  end 

  post '/login' do 
  end 

  post '/tweets' do 
  end 

  patch '/tweets/:id' do 
  end 

  delete '/tweets/:id/delete' do 
  end 

  module Helpers 

  	def current_user 
  	end 

  	def logged_in?
  	end 

  end 

end