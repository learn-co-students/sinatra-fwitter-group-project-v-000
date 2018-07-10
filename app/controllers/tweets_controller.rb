class TweetsController < ApplicationController
  # get '/tweets' do
  #   if logged_in?
  #   erb :'tweets/tweets'
  #   end
  # end

  get '/tweets/new' do
   if logged_in?
    erb :'tweets/create_tweet'
   else
    redirect "/login"
   end
  end

  post '/tweets' do
  if params["Tweet"].empty?
    redirect "tweets/new"
  else
   @tweet = Tweet.create(:content => params["Tweet"])
   @user = User.find_or_create_by(session["user_id"])
   @tweet.user_id = @user.id
   @tweet.save
   redirect("/users/#{@user.slug}")
  end
 end

 get '/tweets/:id/edit' do
   if logged_in?
     @tweet = Tweet.find_by(params[:id])
     erb :"tweets/edit_tweet"
   else
     redirect "/login"
   end
 end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect("/tweets/#{@tweet.id}")
    end
   end

   post '/tweets/:id/delete' do
     if logged_in?
       @tweet = Tweet.find_by(params[:id])
       @tweet.delete
        erb :'tweets/tweets'
     else
       redirect "/login"
     end
   end



end
