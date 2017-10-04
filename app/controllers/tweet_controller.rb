require './config/environment'

class TweetController < ApplicationController
	
  configure do
    set :public_folder, 'public'
    set :views, 'app/views/'
  end
	
	get '/tweets' do
		if signed_in?
			@user=User.find(session[:id])
			erb :'/tweets/index'
		else
			redirect '/login'
		end
	end
	
	get '/tweets/new' do
		if signed_in?
			erb :'/tweets/new'
		else
			redirect '/login'
		end
	end
	
	
	post '/tweets' do
		if !params[:content].empty?
			@user = User.find(session[:id])
			@user.tweets << Tweet.create(content: params[:content])
			redirect '/tweets'
		else
			redirect '/tweets/new'
		end
	end
	
	get '/tweets/:id' do
		if signed_in?
			@tweet = Tweet.find(params[:id])
			erb :'/tweets/show'
		else
			redirect '/login'
		end
	end
	
	get '/tweets/:id/edit' do
		if signed_in?
			@tweet = Tweet.find(session[:id])
			erb :'/tweets/edit'
		else
			redirect '/login'
		end
		
	end
	
	patch '/tweets/:id' do
		@tweet = Tweet.find(session[:id])
		if signed_in? && !params[:content].empty?	
				@tweet.update(content: params[:content])
				redirect "/tweets/#{@tweet.id}"
		elsif signed_in? && params[:content].empty?
				redirect "/tweets/#{@tweet.id}/edit"
		else
			redirect '/login'
		end		
	end
	
	
	delete '/tweets/:id' do
		if signed_in?
			@tweet = Tweet.find(session[:id])
			@tweet.destroy
		else
			redirect '/login'
		end
	end
	
	
end