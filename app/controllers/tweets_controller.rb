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
		# binding.pry
		if session[:user_id] != nil
		  @user = User.find(session[:user_id])
		  
		  erb :'/tweets/new'
		else
		  # binding.pry
		  redirect to '/login'
		end
	end


	get '/tweets/:id' do

		erb :'/tweets/show'
	end

end