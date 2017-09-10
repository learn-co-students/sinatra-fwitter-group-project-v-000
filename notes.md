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
[ ] #current_user => determine who the current user is based on the session id (?)
[ ] #logged_in? => does the session[:id] exist for the current user?

Login
[ ] enable sessions
[ ] set session secret
[ ] seed data?

Routes
[x] get '/' => homepage
[ ] get '/tweets/new' => create a new tweet; tweet gets created and saved to db (cannot be blank!)
[ ] post '/tweets' => process new tweet request
[ ] get '/tweets/:id' => view a single tweet; has link to edit tweet; option to delete tweet
[ ] get '/tweets/:id/edit' => edit a single tweet
[ ] post '/tweets/:id' => process edit request
[ ] post '/tweets/:id/delete' => delete a tweet
[ ] get '/signup' => form to create user - username, email and password
[ ] post '/signup' => create user and persist db, after successful sign up the user is logged in
[ ] get 'login' => display the login form
[ ] post '/login' => process the login and add the user_id to the sessions hash
[ ] get '/logout' => clear session

Views - remember that a user can only CRUD their own tweets!!!
[ ] index.erb => homepage with links to login and signup pages
[ ] new.erb => create a new tweet
[ ] edit.erb => edit a tweet
[ ] show.erb => show a single tweet
