class TweetsController < ApplicationController

  get "/tweets/index" do
    erb :'/tweets/index'
  end
  
  get '/tweets/new' do
    erb :'/tweets/new'
  end

  get '/tweets/:id' do

  end

  get '/tweets/:id/edit' do

  end

  post '/tweets/:id' do

  end

  post '/tweets/:id/delete' do

  end



  get "/tweets/tweets" do
    @tweet = "Tweet"
    erb :'/tweets/tweets'
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content])
    erb :"tweets/index"
  end

end
