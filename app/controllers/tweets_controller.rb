require 'rack-flash'
class TweetsController < ApplicationController
  use Rack::Flash

  get '/tweets' do
    @tweets = Tweet.all

    if logged_in?
      @welcome_msg = session[:welcome]
    
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    logged_in? ? (erb :'tweets/create_tweet') : (redirect '/login')
  end

  post '/tweets' do
    if params[:content].empty?
      redirect '/tweets/new'
    else
      tweet = Tweet.create(content: params[:content])

      tweet.user = User.find(session[:user_id])

      tweet.save

      flash[:message] = "Here is your new tweet!"

      redirect "/tweets/#{tweet.id}"
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    logged_in? ? (erb :'tweets/show_tweet') : (redirect '/login')
  end

  get '/tweets/:id/edit' do
    redirect "/login" unless logged_in?

    @tweet = Tweet.find(params[:id])

    erb :"tweets/edit_tweet"
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])

    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])

      flash[:message] = "Your edit was successfully. Enjoy Learning!!!"

      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])

    current_user.id == @tweet.user_id ? @tweet.delete :
                                        (redirect "/tweets/#{@tweet.id}")

    flash[:message] = "Successfully deleted your tweet. Happy Tweeting!"

    redirect :'/tweets'
  end
end
