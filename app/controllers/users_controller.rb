class UsersController < ApplicationController


  post '/login' do
    @user = User.create(params)
    #raise params.inspect
    session[:user_id] = @user.id # actually logging the user in
    redirect "/"
  end

  post '/signup' do
    @user = User.create(params)
    #raise params.inspect
    session[:user_id] = @user.id # actually logging the user in
    redirect '/tweets'




    # if params[:content] != ""
    #   # create a new entry
    #   @journal_entry = JournalEntry.create(content: params[:content],
    #   user_id: current_user.id, title: params[:title], mood: params[:mood])
    #   flash[:message] = "Journal entry successfully created." if @journal_entry.id
    #   redirect "/journal_entries/#{@journal_entry.id}"
    # else
    #   flash[:errors] = "Something went wrong - you must provide content for your entry."
    #   redirect '/journal_entries/new'
    # end




  end

end
