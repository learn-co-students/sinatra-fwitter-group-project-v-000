class TweetsController < ApplicationController

  get '/tweets' do
    if is_loggedin?
      @user = current_user
      erb :"tweets/tweets"
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if is_loggedin?
      erb :"/tweets/new"
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    if params[:content] != ""
      tweet = Tweet.create(:content => params[:content], :user_id => session[:id])
    else
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if is_loggedin?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if is_loggedin?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params[:content] != ""
      tweet.update(:content => params[:content])
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if is_loggedin? && (tweet.user_id == current_user.id)
      tweet.delete
    else
      redirect to "/login"
    end
  end

end
