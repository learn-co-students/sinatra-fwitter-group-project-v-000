require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

get '/tweets/new' do
  if Helper.is_logged_in?(session)
    erb :'tweets/create_tweet'
  else
    redirect '/login'
  end
end

post '/tweets/new' do
  if params["content"] == ""
    redirect '/tweets/new'
  end
  @user = Helper.current_user(session)
  @tweet = Tweet.create(content: params["content"], user_id: @user.id)
  @user.tweets << @tweet
  redirect :"/tweets/#{@tweet.id}"
end

get '/tweets/:id' do
  if Helper.is_logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :"tweets/show_tweet"
  else
    redirect '/login'
  end
end

get '/tweets/:id/edit' do
  if Helper.is_logged_in?(session)
  @tweet = Tweet.find(params[:id])
  erb :'/tweets/edit_tweet'
else
  redirect '/login'
end
end

post '/tweets/:id/edit' do
  @tweet = Tweet.find(params[:id])
  if @tweet.id == Helper.current_user(session).id
    if params[:content] == ""
      redirect :"/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
    end
  end
  redirect '/tweets'
end

post '/tweets/:id/delete' do
  @tweet = Tweet.find(params[:id])
  if @tweet.id == Helper.current_user(session).id
    @tweet.delete
  end
  redirect :'/tweets'
end

get '/tweets' do
    if Helper.is_logged_in?(session)
      @user = Helper.current_user(session)
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
     redirect '/login'
    end
end

end
