class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      # show a flash message about not being able to nav here? or is it not an issue
      redirect to '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.new(params)
    if logged_in? && tweet.save
      current_user.tweets << tweet
      redirect to "/tweets/#{tweet.id}"
      # why does this think there's no '/tweets/:id' route?
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      # add a flash message here
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id/edit' do
    # is this really the best way to handle this?
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if session[:user_id] == @tweet.id
        erb :'/tweets/edit_tweet'
      end
    else
      # add a flash message here
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && session[:user_id] == @tweet.id
      @tweet.destroy
    else
      redirect to '/tweets'
    end
  end

end
