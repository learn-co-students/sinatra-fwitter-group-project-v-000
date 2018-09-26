<h1>Users</h1>

<% unless locals.empty? %>
  <%= message %>
<% end %>


<h3>Sign Up</h3>
<form action="/signup" method="POST">
  <p>Name: <input type="text" name="username"></p>
  <p>Email: <input type="text" name="email"></p>
  <p>Password: <input type="text" name="password"></p>
  <input class="btn btn-primary" type="submit">
</form>
