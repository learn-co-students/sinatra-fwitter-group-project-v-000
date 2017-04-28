class TweetController < ApplicationController
	get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else 
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      #flash message
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user_id: session[:id])
      #flash msg tweet successfully created
      redirect "/tweets/#{@tweet.id}"
    else
      #flast msg tweet cannot be empty
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
    	@tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
  	if logged_in? && tweet.user == current_user
      tweet.destroy
    end
    redirect '/tweets'
  end
end