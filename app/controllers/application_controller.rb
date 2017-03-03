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

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
	    redirect '/login'
    end
	end

  get '/tweets/:id/delete' do
    if logged_in?
      tweet = Tweet.find(params[:id])
      tweet.delete
    else
	    redirect '/login'
    end
	end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
	    redirect '/login'
    end
	end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
	    redirect '/login'
    end
	end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
	    redirect '/login'
    end
	end

  get '/users/:slug' do
    user = User.find_by(name: params[:slug])
    @tweets = Tweet.find_by(user_id: user.id)
    erb :'/tweets/show'
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

	post '/signup' do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
	end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  post '/tweets' do
    tweet = Tweet.create(user_id: session[:user_id], content: params[:content])
    redirect '/tweets/new'
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
