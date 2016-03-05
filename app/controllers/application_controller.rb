require './config/environment'

class ApplicationController < Sinatra::Base

	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
		enable :sessions
	end

	get '/' do
		erb :index
	end

	get '/signup' do
		if !session[:id].nil?
			redirect '/tweets'
		end
		erb :'/users/create_user'
	end

	post '/signup' do
		@user = User.create(params)
		if params[:username] == "" || params[:password] == "" || params[:email] == ""
			redirect '/signup'
		end

		if @user.save
			session[:id] = @user.id
			redirect '/tweets'
		else
			redirect "/signup"
		end
	end

	post "/login" do
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:id] = @user.id
			redirect "/tweets"
		else
			redirect "/failure"
		end
	end

	get '/tweets' do
		if session[:id].nil?
			redirect '/login'
		end
		@user = User.find_by_id(session[:id])
		erb :'tweets/tweets'
	end

	get '/login' do
		if !session[:id].nil?
			redirect '/tweets'
		end
		erb :'users/login'
	end

	get '/logout' do
		session.clear
		redirect '/login'
	end

	get '/users/:user_slug' do
		@user = User.find_by_slug(params[:user_slug])		
		erb :'/tweets/show_tweet'
	end

	get '/tweets/new' do
		if session[:id].nil?
			redirect '/login'
		end		
		erb :'/tweets/new'
	end

	post '/tweets/new' do
		if params[:content] == ""
			redirect :'/tweets/new'	
		end
		@tweet = Tweet.create(params)
		@tweet.user_id = session[:id]
		@tweet.save
	end

	get '/tweets/:tweet_id' do
		if session[:id].nil?
			redirect '/login'
		end
		@tweet = Tweet.find_by_id(params[:tweet_id])
		erb :'/tweets/display_single_tweet'
	end

	get '/tweets/:tweet_id/edit' do
		@tweet = Tweet.find_by_id(params[:tweet_id])
		if session[:id].nil?
			redirect '/login'
		end
		if session[:id] != @tweet.user_id
			redirect '/tweets/:tweet_id'
		end
		erb :'/tweets/edit'
	end

	post '/tweets/:tweet_id/edit' do
		@tweet = Tweet.find_by_id(params[:tweet_id])
		if session[:id] != @tweet.user_id
			redirect '/tweets/:tweet_id'
		end
		if params[:content] != ""
			@tweet.content = params[:content]
			@tweet.save
		end
		#redirect '/tweets/:tweet_id'
	end

	post '/tweets/:tweet_id/delete' do
		@tweet = Tweet.find_by_id(params[:tweet_id])
		if session[:id] != @tweet.user_id
			redirect '/tweets'
		else
			@tweet.delete
			redirect '/tweets'
		end
	end
end
