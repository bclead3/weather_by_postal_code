# README

This project was built on ASDF (http://asdf-vm.com), and includes the `.tool-versions` file listing the versions of Ruby, NodeJS, and Yarn.
```azure
ruby 3.0.3
nodejs 17.2.0
yarn 1.22.17
```
Once ASDF is installed, here are some ASDF commands to install the dependencies...
```azure
asdf plugin list
asdf plugin list all
asdf plugin add ruby
asdf list all ruby 
asdf install ruby 3.0.3
asdf global ruby 3.0.3
asdf local ruby 3.0.3

asdf plugin add nodejs
asdf list all nodejs
asdf install nodejs 17.2.0
asdf local nodejs 17.2.0

asdf plugin add yarn
asdf list all yarn
asdf install yarn 1.22.17
asdf local yarn 1.22.17

bundle exec rake webpacker:install
```
in a separate command window, run
`./bin/webpack-dev-server`
if it runs... GREAT! If you get an error, I found that adding
`export NODE_OPTIONS=--openssl-legacy-provider` to your shell often solves the problem for me.

Run `bundle install` to load the gems 

* Database creation
run `bundle exec rake db:create` followed by `bundle exec rake db:migrate`

* How to run the test suite
The tests were build with RSpec. Use `rspec` to runn all tests.
The code coverage could be better. I'm not proud of it. I had difficulties with logic in the ./lib/assets/web directory.

* Overall Logic
  * I set up three main classes:
    * LatLongFromAddress
    * PostalCodeForecast
    * ForecastPeriod
  
* Latitude, Longitude, and address are stored in LatLongFromAddress. It populates postal_code, which is required for...
* PostalCodeForecast saves weather station request information. I cache based on postal_code
* ForecastPeriod saves an individual period's forecast

12/20 I added indexes, and found the chache portion wasn't working well. It is working better now.
