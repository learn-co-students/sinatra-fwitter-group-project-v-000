class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

get '/tweets/new' do
  if logged_in?
    erb :'/tweets/new'
  else
    redirect '/login'
  end
end

get '/tweets/:id' do
  if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show_tweet'
  else
    redirect to '/login'
  end
end

post '/tweets' do
  if !logged_in?
     redirect '/'
  end
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
        redirect "/tweets/#{@tweet.id}"
    else
        redirect "/tweets/new"
    end
 end


get '/tweets/:id/edit' do
  set_tweet
  if logged_in?
    if authorized_to_edit?(@tweet)
     erb :'/tweets/edit_tweet'
    else
     redirect '/tweets'
    end
  else
   redirect '/login'
  end
end

patch '/tweets/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          if @tweet.update(content: params[:content])
            redirect to "/tweets/#{@tweet.id}"
          else 
            redirect to "/tweets/#{@tweet.id}/edit"
          end
        else 
          redirect to '/tweets'
        end
      end
    else 
      redirect to '/login'
    end
  end


delete '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.destroy
      end
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

def set_tweet
  @tweet = Tweet.find_by_id(params[:id])
end
end
