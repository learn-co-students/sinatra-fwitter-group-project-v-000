TO DO
[x] Set up directories and files

Models & Migrations
[x] Create User model
[x] Create Tweet model
[x] Users have username (string), email (string), password (string)
[x] A User has_many :tweets
[x] A User has_secure_password
[x] Tweets have content (string) and user_id (for association)
[x] A Tweet belongs_to :user
[x] Create Migrations

Controllers
[x] ApplicationController

Helper Methods
[x] #current_user => determine who the current user is based on the session id (?)
[x] #logged_in? => does the session[:id] exist for the current user?

Login
[x] enable sessions
[x] set session secret
[x] seed data?

Routes
[x] get '/' => homepage
[ ] get '/tweets/new' => create a new tweet; tweet gets created and saved to db (cannot be blank!)
[ ] post '/tweets' => process new tweet request
[ ] get '/tweets/:id' => view a single tweet; has link to edit tweet; option to delete tweet
[ ] get '/tweets/:id/edit' => edit a single tweet
[ ] post '/tweets/:id' => process edit request
[ ] post '/tweets/:id/delete' => delete a tweet
[x] get '/signup' => form to create user - username, email and password
[ ] post '/signup' => create user and persist db, after successful sign up the user is logged in
[x] get 'login' => display the login form
[ ] post '/login' => process the login and add the user_id to the sessions hash
[ ] get '/logout' => clear session

Views - remember that a user can only CRUD their own tweets!!!
[x] index.erb => homepage with links to login and signup pages
[ ] create_tweet.erb => create a new tweet
[ ] edit_tweet.erb => edit a tweet
[ ] show_tweet.erb => show a single tweet
[ ] tweets.erb => show all tweets by a user (?)
[ ] create_user.erb => user sign up form; only logged out users can see
[ ] login.erb => user login page
[ ] show.erb => show user information; logged out users can't see this
[x] layout.erb => html template for site

Misc
[ ] add flash messages
