class TweetsController < ApplicationController

	get '/tweets' do
      if session[:user_id] != nil  
      	@user = User.find(session[:user_id])

	  	erb :'/tweets/index'
	  else

	  	redirect to '/login'
	  end
	end


	post '/tweets' do
	  @tweet = Tweet.create(:content => params[:content])
	  @tweet.user = User.find(session[:user_id])

	  if !@tweet.save

		redirect to '/tweets/new'
	  else
	  	@tweet.save

	  	redirect to '/tweets'
	  end
	end


	get '/tweets/new' do
		if session[:user_id] != nil
		  @user = User.find(session[:user_id])
		  
		  erb :'/tweets/new'
		else

		  redirect to '/login'
		end
	end


	get '/tweets/:id' do
	  if !!session[:user_id]
		@tweet = Tweet.find(params[:id])

		erb :'/tweets/show'
	  else

	  	redirect to '/login'
	  end
	end

	get '/tweets/:id/edit' do
	  if session[:user_id] == nil

	  	redirect to '/login'
	  elsif session[:user_id] == Tweet.find(params[:id]).user_id
	  	@tweet = Tweet.find(params[:id])

		erb :'/tweets/edit'
	  else

	  	redirect to '/tweets'
	  end
	end

	post '/tweets/:id/edit' do
		if session[:user_id] == Tweet.find(params[:id]).user_id
		  @tweet = Tweet.find(params[:id])
		  if params[:content] != ""
		  	@tweet.update(:content => params[:content])

		  	redirect to '/tweets'
		  else

		  	redirect to "/tweets/#{@tweet.id}/edit"
		  end
		else

		  redirect to '/login'
		end
	end

	post '/tweets/:id/delete' do
	  @tweet = Tweet.find(params[:id])

	  if session[:user_id] == Tweet.find(params[:id]).user_id
		@tweet.destroy

		redirect to '/tweets'
	  else

	  	redirect to '/login'
	  end
	end
end