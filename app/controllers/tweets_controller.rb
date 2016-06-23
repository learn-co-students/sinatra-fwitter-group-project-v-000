class TweetsController < ApplicationController

	get '/tweets' do
		if !session[:user_id]
			redirect to '/login'
		else
			@user = User.find(session[:user_id])
			erb :'/tweets/tweets'
		end
	end
end