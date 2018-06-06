require 'rack-flash'
require 'rack/flash/test' # => https://github.com/nakajima/rack-flash/issues/1

class UserController < ApplicationController
  use Rack::Flash

  get '/signup' do

    if !logged_in?
      flash[:message] = "Please create an account"
      erb :'/users/new'
    else
      redirect to '/tweets'
    end

  end

  post '/signup' do
    @user = User.create(params[:user])
    session[:user_id] = @user.id
    @user.save

    redirect to '/tweets'
  end
end