class TweetsController < ApplicationController
	get '/tweets' do
		@tweets = Tweet.all
		erb :'tweets/tweets'
	end

	get '/tweets/:slug' do
    @tweet = Tweet.find_by_slug(params[:slug])
    erb :'tweets/show'
  end
end
