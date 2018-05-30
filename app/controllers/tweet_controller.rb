class TweetController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
<<<<<<< HEAD
      if params[:content] == ""
        redirect '/tweets/new'
      else
        @tweet = current_user.tweets.build(content: params[:content])
        if @tweet.save
          redirect "/tweets/#{@tweet.id}"
        else
          redirect '/tweets/new'
        end
=======
      if params[:content]
        @tweet = Tweet.create(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect '/tweets/new'
>>>>>>> 36e95948dd71620eafc163333d4ad3d98c4c88a7
      end
    else
      redirect '/login'
    end
  end

<<<<<<< HEAD
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      if params[:content] == ""
        redirect "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          if @tweet.update(content: params[:content])
            redirect "/tweets/#{@tweet.id}"
          else
            redirect "/tweets/#{@tweet.id}/edit"
          end
        else
          redirect '/tweets'
        end
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
=======

>>>>>>> 36e95948dd71620eafc163333d4ad3d98c4c88a7
end
