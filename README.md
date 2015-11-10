# Dribbble teams finder

To get started clone the repo then run: `bundle install`

To get a list of teams with their amount of followers run:
`ruby bin/find_teams`

To run the application do:
`ruby bin/console`

To run tests:
`rake`

To open in console:
`pry`
`load 'lib/underbelly.rb'`

###Usage

###Find User

`user_response = Underbelly::User.find('Underbelly')`

`user_response.user.name`

###Find Multi Users

`users_response = Underbelly::User.multi_find('Dribbble,dropbox,focuslab,instagram,Facebook,Underbelly')`

`users_response.first.name`

###Print Names and Followers

`Underbelly::User.print_names_and_followers('Facebook,focuslab,instagram,dropbox,Underbelly,Dribbble')`

Writes a text file call output.txt
