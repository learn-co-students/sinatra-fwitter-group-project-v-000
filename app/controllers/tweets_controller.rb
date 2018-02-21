class TweetsController < ApplicationController

	get '/tweets' do
		# binding.pry
      if session[:user_id] != nil  
      	@user = current_user

	  	erb :'/tweets/index'
	  else

	  	redirect to '/login'
	  end
	end


	post '/tweets' do
	  @tweet = Tweet.create(:content => params[:content])
	  @tweet.user = current_user

	  if !@tweet.save

		redirect to '/tweets/new'
	  else
	  	@tweet.save

	  	redirect to '/tweets'
	  end
	end


	get '/tweets/new' do
		if logged_in?
		  @user = current_user
		  
		  erb :'/tweets/new'
		else

		  redirect to '/login'
		end
	end


	get '/tweets/:id' do
	  if logged_in?
		@tweet = Tweet.find(params[:id])

		erb :'/tweets/show'
	  else

	  	redirect to '/login'
	  end
	end

	get '/tweets/:id/edit' do
	  if !logged_in?

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