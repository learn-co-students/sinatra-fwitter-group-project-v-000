class TweeetsController < ApplicationController
  get '/tweets/new' do
    if !session[:user_id]
      redirect '/login'
    else
      erb :'/tweets/create'
    end
  end
  get '/tweets' do
    @tweets = Tweet.all
    if !session[:user_id]
      redirect '/login'
    else
      erb :'/tweets/show'
    end
  end
  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/tweet'
    else
      redirect to '/login'
    end
  end
  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
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
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if !session[:user_id]
      redirect '/login'
    elsif params[:content] == ""
      redirect to '/tweets/new'
    else
      Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect to '/tweets'
    end
  end
end
