class tweetController < ApplicationController


  get '/tweet' do
    if logged_in?
      @tweet = Tweet.all
      erb :'tweet/tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweet/new' do
    if logged_in?
      erb :'tweet/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweet' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweet/new"
      else
        @tweet = current_user.tweet.build(content: params[:content])
        if @tweet.save
          redirect to "/tweet/#{@tweet.id}"
        else
          redirect to "/tweet/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/tweet/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweet/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweet/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'tweet/edit_tweet'
      else
        redirect to '/tweet'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweet/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweet/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          if @tweet.update(content: params[:content])
            redirect to "/tweet/#{@tweet.id}"
          else
            redirect to "/tweet/#{@tweet.id}/edit"
          end
        else
          redirect to '/tweet'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/tweet/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
      redirect to '/tweet'
    else
      redirect to '/login'
    end
  end
end
