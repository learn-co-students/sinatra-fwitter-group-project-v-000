usernames = %w[Roger Sinatra Ghost MSG BigBull BridgeMan]

users = []

usernames.each do |name|
  user = User.create(username: name, email: 'test@email.com', password: 'test')
  users << user.id
end

tweets = [
  'Be yourself, everyone else is already taken.',
  'So many books, so little time.',
  'Dancing is a good source of exercise.',
  'Einstein was a smart guy, let me tell you.',
  'Be the change that you wish to see in the world.',
  'I would rather be playing Civ 5',
  'That museum was cool',
  'Who wants to watch The Social Network later?',
  'When Pokemon Go came out, that was a big deal.',
  'Do you think things happen for a reason?',
  'I really like bagels. Maybe too much.',
  'Pandemic Legacy got pretty crazy last night.',
  'I think the right movie won the Oscars.',
  'Excited for the end of GoT',
  'Actually watched the NFL combine.',
  'Yankees Chad Green - it needed to be done.',
  'Adam Silver, please make the NBA better.',
  'Lebron James, then MJ.',
  'Charles Barkley is underrated.',
  'I do not like Kevin Durant any longer.',
  'The Golden State Warriors are too good.',
  'I hope the Rockets make a splash in the playoffs.',
  'Remember the ending to Bioshock Infinite?',
  'XCOM is a tough game.'
]

a = users.cycle

tweets.each do |content|
  tweet = Tweet.create(content: content)
  tweet.update(user_id: a.next)
end
  
