When the user submits the signup form, the params hash looks like this:
params = {
  "username" => "@username attribute value of user instance (submitted in form field)",
  "email" => "@email attribute value of user instance (submitted in form field)",
  "password" => "@password attribute value of user instance (submitted in form field)"
}

When the user submits the login form, (which has no email form field), here's the params hash:
params = {
  "username" => "@username attribute value of user instance (submitted in form field)",
  "password" => "@password attribute value of user instance (submitted in form field)"
}

When the logged-in user submits the form to create a new tweet, params hash looks like:
params = {"content" => "@content attribute value of tweet instance"}

When the logged-in user submits the form to edit their own tweet, params hash looks like:
params = {"content" => "@content attribute value of tweet instance"}

* Reminder: the content field in the form to edit a tweet looks like this:
<input type="text" name="content" id="content" value="<%= @tweet.content %>">

* Above, the value of the name property of <input> form field = key in params hash
* The value of the id property of <input> form field = how Capybara finds the field
(see test suite where it says fill_in)
* The value of the value property of the <input> form field is what gets sent through to params hash when the form is submitted. In this case, the @content attribute value of the tweet instance (which was either changed in the edit form or stayed the same) gets sent through, becoming the value corresponding to the "content" key in params hash
