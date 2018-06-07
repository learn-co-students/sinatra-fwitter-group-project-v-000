require 'rack-flash'

class TweetsController < ApplicationController
  use Rack::Flash, :sweep => true

  #-------------CREATE A TWEET -------------

  get '/tweets/new' do
    #form to create a new tweet and post to post '/tweets'
    if !Helpers.logged_in?(session)
      redirect to '/login'
    else
      erb :'tweets/new'
    end
  end

  post '/tweets' do
    #creates new tweet and redirects to '/tweets/#{@tweet.id}'
    @user = Helpers.current_user(session)
    if !!params[:content].empty?
      flash[:message] = "ATTENTION: Tweet can not be blank."
      redirect to '/tweets/new'
    else
      @tweet = Tweet.new(content: params[:content])
      @tweet.user = @user
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  #---------------SHOW TWEET ---------------

  get '/tweets/:id' do
    #finds a tweet by id and shows
    if !Helpers.logged_in?(session)
      redirect to '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    end
  end

  get '/tweets' do
    if !Helpers.logged_in?(session)
      redirect to '/login'
    else
      @user = Helpers.current_user(session)
      erb :'tweets/index'
    end
  end

  #---------------EDIT A TWEET -------------


  get '/tweets/:id/edit' do
    #finds a tweet by id
    #directs to a form for inputs
    #sends params from form to the patch path
    if !Helpers.logged_in?(session)
      redirect to '/login'
    elsif Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
      if !Tweet.find(params[:id])
        flash[:message] = "That tweet does not exist."
        redirect '/tweets'
      elsif @tweet = Tweet.find(params[:id])
        if @tweet.user == @user
          erb :'tweets/edit'
        else
          flash[:message] = "You don't have permission to edit this tweet because it's not yours."
          redirect '/tweets'
        end
      end
    end
  end

  patch '/tweets/:id' do
    #gets params from the form
    #finds and updates the tweets
    #redirects to the show page
    @tweet = Tweet.find(params[:id])
    if !!params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  #---------------DELETE A TWEET----------------

  delete '/tweets/:id/delete' do
    #link present alongside each tweet
    #hits the delete path
    @tweet = Tweet.find(params[:id])
    if !Helpers.logged_in?(session)
      flash[:message] = "ATTENTION: You must be logged in to perform this action."
      redirect to '/login'
    elsif @tweet.user == Helpers.current_user(session)
      @tweet.destroy
      redirect to '/tweets'
    end
  end

end
