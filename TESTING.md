Trailblazer-Rails supports rails 5.2.0 and up.

To run the tests, you need to have the run the following command:
```
bundle install
bundle exec appraisal install # This will install the different version of rails
bundle exec appraisal rake db:create db:schema:load test # Run tests in all versions
bundle exec appraisal rails-7.0 rake db:create db:schema:load test # Run tests in rails 7.0 only
```
