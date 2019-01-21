class TweetsController < ApplicationController
  #
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect "/login"
    end
  end


  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    # Is there a way to use helper methods?

    if logged_in? && params[:tweet][:content] != ""
      @tweet = Tweet.create(params[:tweet])
      # Need to assign user_id to tweet
      @tweet.user = current_user
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    elsif logged_in? && params[:tweet][:content] == ""
      redirect "/tweets/new"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect "/login"
    end
  end

  # post '/tweets/:id/edit' do
  #   redirect "/tweets/:id/edit"
  # end

  get '/tweets/:id/edit' do
    # why does this pass the test: does not let a user edit a tweet they did not create
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user == current_user

      erb :'/tweets/edit'
    elsif logged_in? && @tweet.user != current_user
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    # Need to assign user_id to tweet
    if params[:tweet][:content] != ""

      @tweet.update(params[:tweet])
      # @tweet.save
      redirect "/tweets/#{@tweet.id}"
    # undefined method id when content is empty
    elsif params[:tweet][:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user == current_user
      @tweet.delete
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

end
