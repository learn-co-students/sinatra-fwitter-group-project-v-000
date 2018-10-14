class TweetsController < ApplicationController

  get '/tweets' do
		if logged_in?
			@user = current_user
			@tweets = Tweet.all
			erb :'/tweets/tweets'
		else
			redirect '/login'
		end
	end

  get '/tweets/new' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params['content'])
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end


end
