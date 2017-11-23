class TweeetsController < ApplicationController
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create'
    else
      redirect to '/login'
    end
  end
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/tweet'
    else
      redirect to '/login'
    end
  end
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
       erb :'/tweets/edit'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      tweet = Tweet.find_by_id(params[:id])
      tweet.update(content: params[:content])
      redirect to "/tweets/#{tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      tweet = Tweet.find_by_id(params[:id])
      if tweet.user_id == current_user.id
        tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to '/tweets/new'
    elsif logged_in?
      Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end


end
