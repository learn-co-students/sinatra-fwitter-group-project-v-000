class TweetController < ApplicationController
	get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else 
      flash[:message] = "Please log in first."
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      flash[:message] = "To create a new tweet please log in first."
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user_id: session[:id])
      flash[:message] = "Tweet successfully created."
      redirect "/tweets/#{@tweet.id}"
    else
      flash[:message] = "Tweets cannot be empty. Please retry."
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      flash[:message] = "Please log in first."
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in? && current_user == Tweet.find(params[:id]).user
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      flash[:message] = "Unauthorized edit action"
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if current_user == @tweet.user
      if params[:content] != ""
          flash[:message] = "Tweets successfully updated."
        	@tweet.update(content: params[:content])
          redirect "/tweets/#{@tweet.id}"
      else
        flash[:message] = "Tweets cannot be empty. Please retry."
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else #to dbl check user association with tweet
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
  	if logged_in? && tweet.user == current_user
      flash[:message] = "Tweet successfully destroyed"
      tweet.destroy
    else
      flash[:message] = "Unauthorized delete action"
    end
    redirect '/tweets'
  end
end