class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/new"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        flash[:errors] = "You can't tweet an empty tweet."
        redirect "/tweets/new"
      else
        @tweet = current_user.tweets.new(content: params[:content])
        if @tweet.save
          flash[:message] = "Your tweet was successfully twitted! Tway to go!"
          redirect "/tweets/#{@tweet.id}"
        else
          redirect "/tweets/new"
        end
      end
    else
      flash[:errors] = "You have to be logged in to tweet. Please log in."
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"tweets/show_tweet"
    else
      flash[:errors] = "You have to be logged in to see your tweets page. Please log in."
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :"tweets/edit_tweet"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      if params[:content] == ""
        flash[:errors] = "You can't tweet an empty tweet."
        redirect "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          if @tweet.update(content: params[:content])
            flash[:message] = "Tweet successfully updated!"
            redirect "/tweets/#{@tweet.id}"
          else
            flash[:errors] = "You can't tweet an empty tweet."
            redirect "/tweets/#{@tweet.id}/edit"
          end
        else
          flash[:errors] = "You can only edit your own tweets."
          redirect "/tweets"
        end
      end
    else
      flash[:errors] = "You have to be logged in to edit your tweets. Please log in."
      redirect "/login"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
        flash[:message] = "Tweet successfully deleted!"
        redirect "/tweets"
      else
        flash[:errors] = "You can't delete other peoples tweets. Only your own."
        redirect "/tweets"
      end
    else
      flash[:errors] = "If you're a hacker, go away. Otherwise, you should log in."
      rediret "/login"
    end
  end
end
