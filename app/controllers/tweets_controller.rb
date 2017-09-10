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
    # edit and update the tweet
    redirect to "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id/edit' do
    # if the current user is the tweet creator, then they can view form to edit
    # else redirect them elsewhere and show a flash message?
    erb :'/tweets/edit_tweet'
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
  end

end
