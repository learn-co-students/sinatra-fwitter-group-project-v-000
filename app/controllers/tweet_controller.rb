class TweetController < ApplicationController
	get "/tweets" do 
	  	if !!session[:id]
	  		erb :"tweets/tweets"
	  	else
	  		redirect "/login"
	  	end
  	end

  	get "/tweets/new" do 
  		if !!session[:id]
  			erb :"tweets/create_tweet"
  		else
  			redirect "/login"
  		end
  	end

  	post "/tweets" do 
  		user = User.all.find(session["id"])
		if params[:content] == ""
			redirect "/tweets/new"
		else
			user.tweets << Tweet.create(params)
			redirect "/tweets"
		end
  	end

  	get "/tweets/:id" do 
  		if !!session[:id]
	  		@tweet = Tweet.find(params[:id])
	  		erb :"tweets/show_tweet"
	  	else
	  		redirect "/login"
	  	end
  	end

  	get "/tweets/:id/edit" do
  		if !!session[:id]
  			@tweet = Tweet.find(params[:id])
  			erb :"tweets/edit_tweet"
  		else
  			redirect "/login"
  		end
  	end

  	post "/tweets/:id" do
  		tweet = Tweet.find(params[:id])
  		if params[:content] == ""
  			redirect "/tweets/#{tweet.id}/edit"
  		else
	  		tweet.content = params[:content]
	  		tweet.save
	  		redirect "/tweets/#{tweet.id}"
	  	end
  	end

  	post "/tweets/:id/delete" do
  		tweet = Tweet.find(params[:id])

  		if tweet.user_id == session[:id]
  			tweet.destroy
  			redirect "/tweets"
  		else
  			redirect "/tweets"
  		end
  	end

  	# get "/tweets/:id/delete" do 
  	# 	tweet = Tweet.find(params[:id])

  	# end
  	


end