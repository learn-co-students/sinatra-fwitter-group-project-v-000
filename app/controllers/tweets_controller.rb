class TweetsController < ApplicationController

  get '/tweets' do
    #loads all tweets if user is logged in
    #if not logged in, redirects to login page
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect to "tweets/new"
      else
        @tweet = current_user.tweets.build(content: params[:content])

        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else

          redirect to "/tweets/new"
        end
      end
    else
      redirect to '/login'
    end
  end


  get '/tweets/:id' do
    #if logged in:
    if logged_in?
      #find tweet by id
      @tweet = Tweet.find_by_id(params[:id])
      #displays a single tweet
      erb :'tweets/show_tweet'
      #if not logged in, redirect to login page
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do

    if logged_in?

      @tweet = Tweet.find_by_id(params[:id])

      if @tweet && @tweet.user == current_user

        erb :'tweets/edit_tweet'

      else
        redirect to '/tweets'
      end

    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do

    if logged_in?

      if params[:content] == ""
        redirect to "/tweets/#{params[:id]}/edit"

      else

        @tweet = Tweet.find_by_id(params[:id])

        if @tweet && @tweet.user == current_user

          if @tweet.update(content: params[:content])
            redirect to "/tweets/#{@tweet.id}"

          else
            redirect to "/tweets/#{@tweet.id}/edit"
          end

        else
          redirect to '/tweets'
        end
      end
    else
      #if not logged in, redirect to login
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    #if logged in, find tweet by id and set to @tweets
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      # If current tweet was created by current user, allow to delete
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
      #redirect to '/tweets' page
      redirect to '/tweets'
    else
      #if not logged in, redirect to login page
      redirect to '/login'
    end
  end

end
