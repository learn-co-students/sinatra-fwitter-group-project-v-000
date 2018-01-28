require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    user = User.create(params[:user])

    if user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      user = User.find_by_slug(params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect '/tweets'
        else
          redirect '/signup'
        end
      end

  end


  get '/tweets' do
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  get '/tweets/create' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    @tweet = Tweet.create(params[:tweet])
    binding.pry
    @tweet.username = current_user.username
    @tweet.save
  end


  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    binding.pry
    erb :'/tweets/show_tweet'
  end


  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(params[:tweet])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
  end

post '/tweets/:id/delete' do
  @tweet = Tweet.find_by_id(params[:id])
  @tweet.delete
end

get '/logout' do

  if logged_in
    session.clear
  else
    redirect '/login'
  end
end

  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end #ends AppController class
