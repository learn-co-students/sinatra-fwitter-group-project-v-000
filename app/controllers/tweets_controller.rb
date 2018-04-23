class TweetsController < ApplicationController

  get '/tweets' do #tweet page to display all tweets
    if logged_in?
    @tweets = Tweet.all
     erb :'tweet/tweets'
    else
     redirect '/login'
    end
  end

  get '/tweets/new' do #loads the form
    if logged_in?
      erb :'tweet/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do #creates a tweet
    @user = current_user
    if logged_in? && params[:content].empty?
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect "tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do ##loads tweet page
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in?
      erb :"tweet/show"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do #loads edit form
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if current_user == @tweet.user
        erb :"tweet/edit"
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do ##updates a tweet
    if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user.id == current_user[:id] && !params[:content].empty?
       @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do #delete action
    @tweet = Tweet.find_by_id(params[:id])
    if session[:user_id] == @tweet.user_id
    @tweet.delete
    redirect '/tweets'
    else
      redirect to '/tweets'
    end
  end

end
