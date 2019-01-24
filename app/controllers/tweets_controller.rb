class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      erb :"tweets/index"
    else
      redirect to "/login"  #redirects if user not logged_in
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"tweets/new"
    else
      redirect to "/login"  #redirects if user not logged_in
    end
  end

  post "/tweets" do
    tweet = Tweet.new(params)
    if tweet.save  #validates presence of content
      current_user.tweets << tweet
      redirect to "/tweets/#{tweet.id}"
    end
    redirect to "/tweets/new" #redirects if tweet creation fails
  end

  get "/tweets/:id" do
    if logged_in?
      erb :"tweets/show"
    else
      redirect to "/login"  #redirects if user not logged_in
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      erb :"tweets/edit"
    else
      redirect to "/login"  #redirects if user not logged_in
    end
  end

  patch "/tweets/:id" do
    if current_tweet.update(content: params[:content])  #validates presence of content
      redirect to "/tweets/#{current_tweet.id}"
    else
      redirect to "/tweets/#{current_tweet.id}/edit"
    end
  end

  delete "/tweets/:id/delete" do
    if current_tweet.user == current_user #validates user deleting own tweet
      current_tweet.delete
      redirect to "/users/#{current_user.slug}"
    end
    redirect to "/tweets"
  end

end
