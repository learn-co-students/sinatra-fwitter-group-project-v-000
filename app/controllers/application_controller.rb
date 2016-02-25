require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, 'super secret'
  end

  get '/' do 
  	erb :index
	end

	get '/signup' do
		if !session[:id].nil?
			redirect '/tweets'
		end
		erb :"users/create_user"
	end

	post '/signup' do
		if params[:username].empty?||params[:password].empty?||params[:email].empty?
			redirect '/signup'
		else
			@user = User.create(params)
			session[:id]= @user.id
			redirect '/tweets'
		end
	end

	get '/login' do
		if !session[:id].nil?
			redirect '/tweets'
		end
		erb :'/users/login'
	end

	post '/login' do
		@user =User.find_by(:username=> params[:username])
		
		if @user && @user.authenticate(params[:password])
			session[:id] = @user.id
			redirect '/tweets'
		else
			redirect '/login'
		end
	end

	get '/tweets' do
		if session[:id].nil?
			redirect '/login'
		else

			@tweets= Tweet.all

			erb :"/tweets/tweets"
			
		end
	end

	get '/logout' do
		#binding.pry
		if !session[:id].nil?
			session.clear
			redirect '/login'
		else
			redirect '/'
		end
	end

	get '/users/:user_slug' do
		@user =User.find_by_slug(params[:user_slug])
		erb :'users/show'
	end

	get '/tweets/new' do

		if Helpers.is_logged_in?(session)
			erb :'/tweets/create_tweet'
		else
			redirect '/login'
		end
	end

	post '/tweets' do
		redirect '/tweets/new' if params[:content].empty?
		@user = Helpers.current_user(session)
		@tweet = Tweet.create(content: params[:content], user_id: @user.id)
		redirect "/tweets/#{@tweet.id}"
	end

	get '/tweets/:id' do
		if session[:id].nil? #||session[:id]!=Tweet.find(params[:id]).user_id
			redirect '/login'
		end

		@tweet= Tweet.find(params[:id])
		erb :"/tweets/show_tweet"
	end

	get '/tweets/:id/edit' do 
		if !Helpers.is_logged_in?(session)||Tweet.find(params[:id]).user_id!=session[:id]
			redirect '/login'
		end
		@tweet= Tweet.find(params[:id])
		erb :"/tweets/edit_tweet"
	end

	post '/tweets/:id' do
		if params[:content]==""
			redirect "/tweets/#{params[:id]}/edit"
		end
		@tweet = Tweet.find(params[:id])
		@tweet.update(:content=> params[:content])
		@tweet.save
		redirect "/tweets/#{params[:id]}"
	end

	post '/tweets/:id/delete' do
		#binding.pry
		if session[:id]!=Tweet.find(params[:id]).user_id
			redirect '/tweets'
		end
		
		@tweet=Tweet.find(params[:id])
		@tweet.delete
		@user=User.find(session[:id])
		#redirect "/users/#{@user.slug}"
	end









end