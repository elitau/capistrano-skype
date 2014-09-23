# Capistrano::Skype

Capistrano 3 tasks to notify deployments via skype. Currently works only on MacOS X via applescripts.

Wide parts of the code are based on Avner Cohens [talking-capistrano](https://github.com/fiverr/talking-capistrano).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-skype'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-skype

## Usage

Set ```skype_chat_name``` in your deploy.rb to define in which chat the notifications should be posted. If you have a hosted repository like github, also set ```project_url``` to have links to the commit page in the notification. 

Alternatively it is possible to set custom messages for the ```deploy:started```, ```deploy:finished``` and ```deploy:rollback``` hooks. See example below.

### Example

```ruby
set :skype_chat_name, "Project X"
set :project_url,     "https://github.com/company_x/project_y"
set :started_notification, "[#{fetch(:application)}]" \
                           "(#{fetch(:stage).upcase})" \
                           " Deploy started" \
                           " (F)"
set :finished_notification, -> { "Finished deploy of " \
                                 " https://github.com/company_x/project_y/commit/#{fetch(:current_revision)}" \
                                 " (#{fetch(:branch)})" \
                                 " (sun)"
                               }
```

## Contributing

1. Fork it ( https://github.com/elitau/capistrano-skype/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
