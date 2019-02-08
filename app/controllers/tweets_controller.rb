class TweetsController < ApplicationController
  # Could use flash messages throughout this controller with each redirect.

  get '/tweets' do
      # Displays all Tweets to logged in users
    redirect "/login" if !logged_in?
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
      # Allows logged in users to view and complete the 'New Fweet' form.
    redirect "/login" if !logged_in?
    erb :'tweets/new'
  end

  post '/tweets' do
      # Accepts information from the 'New Fweet' form.
    redirect "/tweets/new" if params[:content].empty?
      # Will send the user back to the form if no Fweet content was submitted.
    @tweet = Tweet.create(content: params[:content])
      # Creates a new Fweet from the submitted content.
    @tweet.user_id = current_user.id
      # Associates the Fweet with the User.
    @tweet.save
      # Saves the association.
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
      # Shows a logged in user their Fweet.
    redirect "/login" if !logged_in?
    @tweet = Tweet.find_by(id: params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
      # Allows a logged in user to edit their own Fweet.
    redirect "/login" if !logged_in?
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.user_id == current_user.id
        # Makes sure that the user owns the Fweet they want to edit.
      erb :'tweets/edit_tweet'
    else
      redirect "/tweets/"
    end
  end

  patch '/tweets/:id' do
      # Sends the edits to teh server and updates the Fweet.
    @tweet = Tweet.find_by(id: params[:id])
    redirect "/tweets/#{@tweet.id}/edit" if params[:content].empty?
      # Will send the user back to the edit form if no Fweet content was submitted.
    @tweet.update(content: params[:content])
    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
      # Allows a logged in user to delete their own Fweet.
    tweet = Tweet.find_by(id: params[:id])
    tweet.delete if tweet.user_id == current_user.id
    redirect "/tweets"
  end

end
