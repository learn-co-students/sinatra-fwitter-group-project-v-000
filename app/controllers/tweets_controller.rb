class TweetsController < ApplicationController
  #-------------CREATE A TWEET -------------

  get '/tweet/new' do
    #form to create a new tweet and post to post '/tweets'
    erb :new
  end

  post '/tweets' do
    #creates new tweet and redirects to '/tweets/#{@tweet.id}'
    # redirect to "/tweets/#{@tweet.id}"
  end

  #---------------SHOW TWEET ---------------

  get '/tweets/:id' do
    #finds a tweet by id and shows
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
    else
      redirect to '/'
    end

    erb :'tweets/index'
  end

  #---------------EDIT A TWEET -------------

  get '/tweets/:id/edit' do
    #finds a tweet by id
    #directs to a form for inputs
    #sends params from form to the patch path
    erb :edit
  end

  patch '/tweets/:id' do
    #gets params from the form
    #updates the tweets
    #redirects to the show page
    redirect to "/tweets/#{@tweet.id}"
  end

  #---------------DELETE A TWEET----------------

  get '/tweets/:id/delete' do
    #link present alongside each tweet
    #hits the delete path

  end

  delete '/tweets/:id' do
    #finds the tweet and deletes it
    @tweet = Tweet.find(params[:id])
    @tweet.destroy

    #redirects to user's full list of tweets?
  end

end
