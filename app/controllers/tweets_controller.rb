class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/twitter/index'
    else
      redirect to "/users/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'twitter/new'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'twitter/show'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user == current_user
      erb :'twitter/edit'
      end
    else
      redirect "/login"
    end
  end

  post '/tweets/new' do
    unless params[:content] == ""
      @tweet = Tweet.create(params)
      redirect '/tweets'
    end
    redirect "/tweets/new"
  end

  delete '/tweets/:id/delete' do
    if logged_in
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user == current_user
         @tweet.delete
      end
       redirect "/tweets"
      else
      redirect "/failure"
      end
    end

  post '/tweets/:id' do
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
      redirect to '/login'
    end
  end



end
