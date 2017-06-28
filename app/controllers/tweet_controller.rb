class TweetController < ApplicationController

get '/tweets' do
  if logged_in?
    @tweets = Tweet.all
    erb :"tweets/home"
  else
    redirect "/login"
  end
end

get '/tweets/new' do
  if logged_in?
    erb :"tweets/new"
  else
    redirect '/login'
  end
end

get '/tweets/:id' do
  if logged_in?
    @tweet = Tweet.find_by(id: params[:id])
    erb :"tweets/show"
  else
    redirect '/login'
  end
end

get '/tweets/:id/edit' do
  if logged_in?
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.user_id == current_user.id
      erb :"tweets/edit"
    else
      redirect '/tweets'
    end
  else
    redirect '/login'
  end
end

post '/tweets' do #new tweet
    if params[:content] == ""
      redirect "/tweets/new"
    else
    @tweet = current_user.tweets.create(content: params[:content])
    redirect "/tweets/#{@tweet.id}"
  end
end

post '/tweets/:id' do #edit tweet
  if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
  else
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end
end

post '/tweets/:id/delete' do #delete tweet
  if logged_in?
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
  else
    redirect '/login'
  end
end

end
