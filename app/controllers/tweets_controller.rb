class TweetsController < ApplicationController

  get '/tweets' do
    redirect '/login' unless is_logged_in?(session)
    @user = current_user(session)
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  #get '/tweets' do
#    if logged_in?
#      @user = User.find_by(id: session[:user_id])
  #    @tweets = Tweet.all
  #    erb :'/tweets/tweets'
#    else
  #    redirect to '/login'
  #  end


  post '/tweets' do
    redirect '/tweets/new' if params[:content].empty?
    user = User.find(session[:user_id])
    user.tweets.create(content: params[:content])
    redirect '/tweets'
  end

  #post '/tweets' do
    #if !params.values.all? {|v| !v.blank?}
      #redirect to 'tweets/new'
    #else
      #tweet = Tweet.create(params)
      #current_user.tweets << tweet
      #current_user.save
      #redirect to "/tweets/#{tweet.id}"
    #end
  #end

  get '/tweets/new' do
    if is_logged_in?(session)
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    redirect 'login' unless is_logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  #get '/tweets/:id' do
  #  if logged_in?
  #    @tweet = Tweet.find_by_id(params[:id])
  #    erb :'/tweets/show_tweet'
  #  else
  #    redirect to '/login'
  #  end
  #end

  get '/tweets/:id/edit' do
    redirect 'login' unless is_logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  end

#  get '/tweets/:id/edit' do
#    if logged_in?
#      @tweet = Tweet.find_by_id(params[:id])
#      if @tweet.user.id == current_user.id
#        erb :'/tweets/edit_tweet'
#      else
#        rediect to '/tweets'
#      end
#    else
#      redirect to '/login'
#    end
#  end


  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    redirect "/tweets/#{tweet.id}/edit" if params[:content].empty?
    tweet.update(content: params[:content])
    redirect "/tweets/#{tweet.id}"
  end

  #  patch '/tweets/:id' do
  #    if params[:content] == ""
  #      redirect to "/tweets/#{params[:id]}/edit"
  #    else
  #      @tweet = Tweet.find_by_id(params[:id])
  #      @tweet.content = params[:content]
  #      @tweet.save
  #      redirect to "/tweets/#{@tweet.id}"
  #    end
  #  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    redirect "/tweets/#{tweet.id}" unless current_user(session) == tweet.user
    tweet.destroy
    redirect "/tweets"
  end
end

#    delete '/tweets/:id/delete' do
#      @tweet = Tweet.find_by_id(params[:id])
#      if @tweet.user.id == current_user.id
#        @tweet.delete
#        redirect to '/tweets'
#      else
#        redirect '/tweets'
#      end
#    end
