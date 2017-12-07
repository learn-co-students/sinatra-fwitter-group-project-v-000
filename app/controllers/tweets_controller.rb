class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do #loads tweet create form
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do #processes form submission, saves to database
    if params[:content]== ""
      redirect to "/tweets/new"
    else
      @tweet = current_user.tweets.create(:content => params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do #displays information for a single tweet
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do #loads form to edit
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      #binding.pry
      if @tweet.user_id == current_user.id
        erb :'tweets/edit_tweet'
      end
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id/edit' do #updates tweet entry in database
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do #loads delete form(just a submit button) on show page
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end
end
