class TweetsController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/tweets/show"
  end
end
