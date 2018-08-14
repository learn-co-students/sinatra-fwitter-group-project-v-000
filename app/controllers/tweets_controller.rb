class TweetsController < ApplicationController

  get '/tweets' do
    @user = current_user(session)

    if logged_in?(session)
      erb :tweets
    else
      redirect "/login"
    end
  end
  
  get "/tweets/new" do
    @user = current_user(session)

    if logged_in?(session)
      erb :"/tweets/new"
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    @user = current_user(session)

    tweet = Tweet.create(params[:tweet])

    if tweet.valid?
      @user.tweets << tweet
    else
      redirect "/tweets/new"
    end

    redirect "/users/#{@user.slug}"
  end

  get "/tweets/:id" do
    @user = current_user(session)
    @tweet = Tweet.find_by_id(params[:id])

    if logged_in?(session)
      erb :"/tweets/show"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    @user = current_user(session)
    @tweet = Tweet.find_by_id(params[:id])

    if logged_in?(session) && @tweet.user == @user
      erb :"/tweets/edit"
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    valid_tweet = Tweet.new(params[:tweet])

    if valid_tweet.valid?
      @tweet.update(params[:tweet])
      @tweet.save

      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end

  end

  delete "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])

    if @tweet.user == current_user(session)
      tweet = Tweet.find_by_id(params[:id])
      tweet.destroy
    end

    redirect "/tweets"
  end


end
