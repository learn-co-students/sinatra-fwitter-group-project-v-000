class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    @tweet = current_user.tweets.build(content: params[:content])
    # @tweet = Tweet.new(content: params[:content], user: current_user)

    if logged_in?
      if @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/new"
      end
    else
      redirect "/login"
    end

  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])

    if logged_in?
      # binding.pry
      if @tweet && @tweet.user == current_user
        erb :'/tweets/edit_tweet'
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])

    if logged_in?
      if params[:content].empty?
        redirect "/tweets/#{params[:id]}/edit"
      else
        if @tweet && @tweet.user == current_user
          if @tweet.update(content: params[:content])
            redirect "/tweets/#{@tweet.id}"
          else
            redirect "/tweets/#{@tweet.id}/edit"
          end
        else
          redirect "/tweets"
        end
      end
    else
      redirect "/login"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])

    if logged_in?
      # binding.pry
      if @tweet && @tweet.user == current_user
        @tweet.destroy
      end
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

end
