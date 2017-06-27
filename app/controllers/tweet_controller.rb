class TweetController < ApplicationController

get '/tweets' do
  if logged_in?
    @tweets = Tweet.all
  else
    redirect "/"
  end
  erb :"tweets/home"
end

get '/tweets/new' do
  erb :"tweets/new"
end

get '/tweets/:id' do
  erb :"tweets/show"
end

get '/tweets/:id/edit' do
  erb :"/tweets/edit"
end

post '/tweets' do #new tweet
  redirect "/tweets/#{@tweet.id}/edit"
end

post '/tweets/:id' do #edit tweet
  redirect "/tweets/#{@tweet.id}"
end

post '/tweets/:id/delete' do #delete tweet
  redirect "/tweets"
end

end
