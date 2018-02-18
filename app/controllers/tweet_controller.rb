require 'pry'

class TweetController < ApplicationController
get '/tweets' do

  if logged_in?
    @user = User.find_by_id(session[:user_id])
    erb :'/tweets/tweets'
  else
    redirect to '/login'
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user: current_user)
         @tweet.save
         redirect '/tweets'
       else
         redirect to '/tweets/new'
       end

  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])
    if logged_in? && @tweet.user_id == current_user.id
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
     if params[:content].empty?
       redirect to "/tweets/#{params[:id]}/edit"
     else
       @tweet = Tweet.find_by(params[:id])
       @tweet.update(content: params[:content])

       redirect to "/tweets/#{@tweet.id}"
     end
   end

   post '/tweets/:id/delete' do

     tweet = current_user.tweets.find_by(id: params[:id])
       if tweet && tweet.destroy
         redirect "/tweets"
      else
        redirect "/login"
      end
    end

end
