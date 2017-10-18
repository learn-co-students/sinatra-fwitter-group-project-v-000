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


Test Tasks
ApplicationController
  Homepage
x    loads the homepage
  Signup Page
x    loads the signup page
    signup directs user to twitter index (FAILED - 1)
    does not let a user sign up without a username (FAILED - 2)
    does not let a user sign up without an email (FAILED - 3)
    does not let a user sign up without a password (FAILED - 4)
    does not let a logged in user view the signup page (FAILED - 5)
  login
x    loads the login page
    loads the tweets index after login (FAILED - 6)
    does not let user view login page if already logged in (FAILED - 7)
  logout
    lets a user logout if they are already logged in (FAILED - 8)
    does not let a user logout if not logged in (FAILED - 9)
    does not load /tweets if user not logged in (FAILED - 10)
    does load /tweets if user is logged in (FAILED - 11)
  user show page
    shows all a single users tweets (FAILED - 12)
  index action
    logged in
      lets a user view the tweets index if logged in (FAILED - 13)
    logged out
      does not let a user view the tweets index if not logged in (FAILED - 14)
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

User
x  can slug the username
x  can find a user based on the slug
x  has a secure password
