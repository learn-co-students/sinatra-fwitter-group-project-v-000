require 'pry'
class TweetsController < ApplicationController

  get '/tweets/new' do
    if session[:id]
      erb :'/tweets/create'
    else
      redirect to('/login')
  end
end

  post '/tweets/new' do
    user = User.find_by_id(session[:id])
    if !params[:content].empty?
    tweet = Tweet.new(content: params[:content])
    tweet.user_id = user.id
    tweet.save
  else
    redirect to('/tweets/new')
  end
  end

  get '/tweets/:id' do
    if session[:id]
      @session = session
    @tweet = Tweet.find_by_id(params[:id])
    erb :"/tweets/show"
else
  redirect to("/login")
end
  end

  get "/tweets/:id/edit" do
    if session[:id]
      @tweet = Tweet.find_by_id(params[:id])
    erb :"/tweets/edit"
  else
    redirect to("/login")
  end
  end

  post "/tweets/:id" do
    tweet = Tweet.find_by_id(params[:id])
      if !params[:content].empty?
        tweet.update(content: params[:content])
        tweet.save
        redirect to("/tweets/#{tweet.id}")
      else
        redirect to("/tweets/#{tweet.id}/edit")
      end
  end

#   get "/tweets/:id/delete" do
#     if session[:id]
#     @tweet = Tweet.find_by_id(params[:id])
#     erb :"/tweets/delete"
#   end
# end

  post "/tweets/:id/delete" do
    tweet = Tweet.find_by_id(params[:id])
    if session[:id] != tweet.user_id
      redirect to("/tweets")
    else
    tweet.delete
  end
  end




end
