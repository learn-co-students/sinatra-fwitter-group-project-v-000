class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/tweets"  
    else
      redirect to '/login'   
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = User.find_by(:id => session[:user_id])
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(:content => params[:content], :user_id => session[:user_id])
      @tweet.save
      redirect to "/tweets"
    else
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(:id => params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(:id => params[:id])
      if @tweet && @tweet.user == current_user
        erb :'/tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find_by(:id => params[:id])
    @tweet.update(content: params[:content])
  end

  patch '/tweets/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by(:id => params[:id])
        if @tweet && @tweet.user == current_user
          @tweet.update(:content => params[:content])
          redirect to "/tweets/#{@tweet.id}/edit"
        else
          redirect to '/tweets'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by(:id => params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.destroy
      end
        redirect to '/tweets'
    else
      redirect to '/login'
    end  
  end
end