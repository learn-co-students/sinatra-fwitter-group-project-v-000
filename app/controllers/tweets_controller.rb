require "./config/environment"

class TweetsController < ApplicationController


get '/tweets/new' do
     if Helpers.logged_in?(session)
     @user = Helpers.current_user(session)
     erb :'/tweets/new'
     
     else
     redirect '/login'
     end
end


post '/tweets' do
    if Helpers.logged_in?(session)
     @user = Helpers.current_user(session)
    @user.tweets << Tweet.create(:content => params[:content])
    @user.save
    redirect "/users/#{@user.username}/home"

    else
     redirect '/login'
    end

end



#create

#show


#edit


#deleted



end