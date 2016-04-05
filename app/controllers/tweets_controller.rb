class TweetsController < ApplicationController

  get '/tweets' do #show all tweets
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do #load new tweet form
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do #process new tweet form
    if logged_in?
      if params[:content] == ""
        redirect '/tweets/new'
      else
        @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
        redirect "/tweets/#{@tweet.id}"
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do #show single tweet
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = current_user
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do #load edit form
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
        #only user who created tweet, can edit 
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do #process edit form
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id
      if params[:content] == ""
        redirect "/tweets/#{@tweet.id}/edit"
      else
        @tweet.update(content: params[:content])
      end
    end
    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do #process delete form
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.destroy  
      else
        redirect '/login'
      end
    else
      redirect '/login'
    end
  end

end