require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/failure' do
		erb :failure
	end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
	    erb :'/users/login'
    end
	end

	get '/logout' do
		session.clear
		redirect '/login'
	end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
	end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
	    redirect '/users/login'
    end
	end

  get '/users/:slug' do

  end

	post '/signup' do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
	end

	post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/failure'
    end
  end

  def self.slug(name)
    name.tr(' ', '-').tr("'", "").downcase
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
