class TweetsController < ApplicationController
  # Loads a page with all of the tweets
  get '/tweets' do
    if logged_in? # The user can only see this page if they're logged in
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  # Loads the create_tweet page, which contains a form to create a new tweet
  get '/tweets/new' do
    if logged_in? # The user can only create a tweet if they're logged in
      erb :'tweets/create_tweet'
    else
      redirect to '/login' # Otherwise, they are directed to the login page
    end
  end

  # Gets the input from the create tweet form and creates the tweet
  post '/tweets' do
    if params[:content] == "" # The user cannot create a blank tweet
      redirect to '/tweets/new'
    else
      @tweet = current_user.tweets.create(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  # Loads a page displaying a specific tweet
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  # Loads the edit_tweet page, which contains a form for the user to edit a tweet
  get '/tweets/:id/edit' do
    if logged_in? # The user can only edit a tweet if they're logged in
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id # A user can only edit their own tweets
        erb :'/tweets/edit_tweet'
      else
        redirect to "/tweets/#{@tweet.id}"
      end
    else
      redirect to '/login' # If they aren't logged in, they're directed to the login page.
    end
  end

  # Gets the input from the form to edit a tweet
  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    if params[:content] == "" # The user cannot create a blank tweet
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content] # Updates the tweet with the new comment
      @tweet.save

      redirect to "/tweets/#{@tweet.id}"
    end
  end

  # Deletes a tweet
  delete '/tweets/:id/delete' do
    if logged_in? # A user can only delete a tweet if they're logged in
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id # A user can only delete their own tweets
        @tweet.delete
        redirect to "/tweets"
      else
        redirect to "/tweets" # Redirect back to the list of tweets
      end
    else
      redirect to '/login' # If the user isn't logged in, they're directed to the login page.
    end
  end


end