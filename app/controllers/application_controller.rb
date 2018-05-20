require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "passwort_sehr_sicher"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    #how to incorporate flash message if there was an error signing up?
    erb :'/users/create_user'
  end

  post '/signup' do
    #sign in user using params
    #add user_id to sessions hash
    #does not allow signup without username/email/password -> redirect again to signup
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      #add || to check if email includes @ + .com?
      flash[:message] = "Please enter all fields with required information."
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets/tweets'
    end
  end

  get '/tweets/tweets' do
    erb :'/tweets/tweets'
  end

end
