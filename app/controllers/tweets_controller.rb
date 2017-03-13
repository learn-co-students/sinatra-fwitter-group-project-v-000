class TweetsController < ApplicationController


  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
    erb :'tweets/index'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'tweets/new'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
    @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
    redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect "/login"
    else
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    end
  end

  patch '/tweets/:id' do
    if !logged_in?
      redirect "/login"
    elsif params[:content] == ""
      redirect "tweets/#{params[:id]}/edit"
    else
      tweet = Tweet.find(params[:id])
      tweet.content = params[:content]
      tweet.save
      redirect "/tweets/#{tweet.id}"
    end
  end

  delete '/tweets/:id' do
    if !logged_in?
      redirect "/login"
    elsif current_user.id != Tweet.find(params[:id]).user_id
      redirect '/tweets'
    else
      Tweet.delete(params[:id])
      redirect '/tweets'
    end
  end

  #post '/tweets/:id/delete' do
  #  redirect "/tweets/#{params[:id]}/delete"
  #end

end
