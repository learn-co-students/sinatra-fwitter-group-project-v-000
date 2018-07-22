class TweetsController < ApplicationController

  get '/tweets' do #tweets page request
    @user = User.find_by_id(session[:user_id])
    if is_logged_in?
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect :"/login"
    end
  end

  get '/tweets/new' do #new tweets page request
    if is_logged_in?
      erb :"tweets/new"
    else
      redirect :login
    end
  end

  post '/tweets' do #create tweet and redirect
    if !is_logged_in?
      redirect "/login"
    else
      if params[:content] != ""
        @tweet = Tweet.create(content: params[:content])
        current_user.tweets << @tweet
        redirect :"/tweets/#{@tweet.id}"
      else
        redirect :'/tweets/new'
      end
    end
  end

  get "/tweets/:id" do #single tweet page request
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show"
    else
      redirect :login
    end
  end

  get "/tweets/:id/edit" do #edit tweet page request
    @tweet = Tweet.find_by_id(params[:id])
    erb :"/tweets/edit"
  end

  patch '/tweets/:id' do #update tweet
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(params["content"])
    redirect :"/tweets/#{@tweet.id}"
  end

  delete "/tweets/:id/delete" do #delete
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
    erb :"tweets/deleted"
  end


end
