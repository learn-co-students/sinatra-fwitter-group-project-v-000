class TweetsController < ApplicationController


  get '/tweets' do #tweets page request
    @current_user = User.find_by_id(session[:user_id])
    if @current_user
      erb :"/tweets"
    else
      erb :"/sessions/failure"
    end
  end

  get '/tweets/new' do #new tweets page request
    erb :"tweets/new"
  end

  post '/tweets' do #create tweet and redirect
    @tweet = Tweet.create(params[:tweet])
    redirect :"/tweets/#{@tweet.id}"
  end

  get "/tweets/:id" do #single tweet page request
    @tweet = Tweet.find_by_id(params[:id])
    erb :"/tweets/show"
  end

  get "/tweets/:id/edit" do #edit tweet page request
    @tweet = Tweet.find_by_id(params[:id])
    erb :"/tweets/edit"
  end

  patch '/tweets' do #update tweet
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
