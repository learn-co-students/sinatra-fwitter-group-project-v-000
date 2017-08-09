class TweetsController < ApplicationController


# index action
  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      erb :tweets
    else
      redirect to '/login'
    end
  end


  # new action

  get '/tweets/new' do
    if session[:user_id]
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  #show action

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    @user = User.find(session[:user_id])
    if params[:content] == ""   #content blank
      redirect to '/tweets/new'
    else
      @tweet = @user.tweets.create(:content => params[:content])
      # adding new tweet.
    redirect to "/tweets/#{@tweet.id}"
    end
  end

  #edit action

  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find_by(params[:id])  #find_by vs find?
        if @tweet.user_id == current_user.id
          erb :'/tweets/edit'
        else
          redirect to '/tweets'
        end
    else
      redirect '/login'
    end
  end


# ApplicationController edit action logged in lets a user edit their own tweet if they are logged in
# pplicationController edit action logged in does not let a user edit a text with blank content

  patch '/tweets/:id' do
    # raise params.inspect
    @tweet = Tweet.find_by(params[:id])
    if params[:content] == ""
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end


  # delete action

  delete '/tweets/:id/delete' do
    if session[:user_id]
      @tweet = Tweet.find_by(params[:id])
      if @tweet.user_id == current_user.id  #only the correct user
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
