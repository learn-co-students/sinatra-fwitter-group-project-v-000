require 'pry'
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    # @user = User.create(params["user"])

  end

  post '/signup' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect :'/tweets'
    redirect :'/tweets/signup'
  end

  get '/login' do

  end

  post '/login' do

  end




end


#rspec ./spec/controllers/application_controller_spec.rb --fail-fast
