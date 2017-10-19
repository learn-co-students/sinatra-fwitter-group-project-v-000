What I've done so far:

1. Set-up folder structure
2. Created migrations
3. Created and associated models with `has_secure_password`
(model tests are passing)
4. Added sessions to controller
5. Checked to make sure controller and `Rack::MethodOverride` are in config.ru
6. Created routes to '/', '/login', and '/signup'
7. Created layout view
8. Created index view


Second Session - 10/18 5:46 PM
1. Updated '/signup' route to:
`get "/signup" do
  if logged_in?
    redirect "/tweets"
  else
    erb :'/users/create_user'
  end
end`
2. Created Tweets page, added '/tweets' route to Tweets Controller
3. Created User Show Page, added '/users/:id' route to Users Controller
4. Added id="submit" to login page form button
5. Created '/tweets/:id/edit' route and edit_tweet view (not fully tested yet)


Third Session - 10/18 10ish PM
1. In show_tweet.erb, fixed typo in word 'edit' on line 11
2. Updated get '/tweets/:id/edit' to TweetsController
3. Added patch '/tweets/:id' to TweetsController
4. Made minor edits to edit_tweet.erb



Test Tasks

  new action
    logged in
      lets user view new tweet form if logged in (FAILED - 15)
      lets user create a tweet if they are logged in (FAILED - 16)
      does not let a user tweet from another user (FAILED - 17)
      does not let a user create a blank tweet (FAILED - 18)
    logged out
      does not let user view new tweet form if not logged in (FAILED - 19)
  show action
    logged in
      displays a single tweet (FAILED - 20)
    logged out
      does not let a user view a tweet (FAILED - 21)
  edit action
    logged in
      lets a user view tweet edit form if they are logged in (FAILED - 22)
      does not let a user edit a tweet they did not create (FAILED - 23)
      lets a user edit their own tweet if they are logged in (FAILED - 24)
      does not let a user edit a text with blank content (FAILED - 25)
    logged out
      does not load let user view tweet edit form if not logged in (FAILED - 26)
  delete action
    logged in
      lets a user delete their own tweet if they are logged in (FAILED - 27)
      does not let a user delete a tweet they did not create (FAILED - 28)
    logged out
      does not load let user delete a tweet if not logged in (FAILED - 29)
