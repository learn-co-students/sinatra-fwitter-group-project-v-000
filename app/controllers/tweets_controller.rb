class TweetsController < ApplicationController

  get '/tweets' do
    if !!logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if !!logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !!logged_in?
      @user = current_user
        if !params[:content].blank?
          @user.tweets << Tweet.create(content: params[:content])
          redirect '/tweets'
        else
          redirect '/tweets/new'
        end
    end
  end

  get '/tweets/:id' do
    if !!logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end


  get '/tweets/:id/edit' do
    if !!logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    #binding.pry
    if !!logged_in? && !params[:content].blank?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(content: params[:content])
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
   end

   delete '/tweets/:id' do
      if !!logged_in?
        @tweet = Tweet.find_by_id(params[:id])
          if @tweet.user == current_user
            @tweet.destroy
            redirect '/tweets'
          else
          redirect '/login'
       end
      end
    end


end
