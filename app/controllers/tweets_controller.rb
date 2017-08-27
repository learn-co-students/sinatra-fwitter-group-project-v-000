class TweetsController < ApplicationController

  get '/tweets/new' do
    if is_logged_in?(session)
      erb :"/tweets/create_tweet"
    else
      flash[:message] = "You must be logged in to post a tweet!"
      redirect to "/users/login"
    end
  end

  post '/tweets/new' do
    if params[:content] != ""
      @user = current_user(session)
      @user.tweets << Tweet.create(params)
      redirect to '/tweets'
    end
    redirect to :'/tweets/new'
  end

  get '/tweets' do
    @user = current_user(session)
    if is_logged_in?(session)
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  post '/tweets/:id/edit' do
    if is_logged_in?(session) && params[:content] != ""
      @tweet = Tweet.find_by({:id => params[:id]})
      if @tweet.user == current_user(session)
        @tweet.update({:content => params[:content]})
      else
        flash[:message] = "You can only edit your own tweets!"
      end
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  post '/tweets/:id/delete' do

    if is_logged_in?(session)
      tweet = Tweet.find_by({:id => params[:id]})
      if tweet.user == current_user(session)
        tweet.delete
      else
        flash[:message] = "You cannot delete someone else's tweet!"
      end
    end
    redirect to "/tweets"
  end


  get '/tweets/:id/edit' do
    if is_logged_in?(session)
      @tweet = Tweet.find_by({:id => params[:id]})
      if @tweet
        erb :"/tweets/edit_tweet"
      else

        flash[:message] = "Could not find tweet with id: #{params[:id]}"
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find_by({:id => params[:id]})
    if @tweet
      redirect to "/tweets/:id"
    else
      flash[:message] = "Could not find tweet with id: #{params[:id]}"
      redirect to "/tweets"
    end
  end

  get '/tweets/:id' do

    @tweet = Tweet.find_by({:id => params[:id]}) #Not using find because this will return nil, wheres find throws active record error
    if @tweet
      if is_logged_in?(session)
        erb :"/tweets/show_tweet"
      else
        redirect to "/login"
      end
    else
      flash[:message] = "Could not find tweet with id: #{params[:id]}"
      redirect to "/tweets"
    end
  end


end
