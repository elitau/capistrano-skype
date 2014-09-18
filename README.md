# Capistrano::Skype

Capistrano 3 tasks to notify deployments via skype. Currently works only on MacOS X.

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

Set ```skype_chat_name``` in your deploy.rb to define in which chat the notifications should be posted. If have a hosted repository like github, also set ```project_url``` to have links to the commit page in the notification.

### Example

```ruby
set :skype_chat_name, "Project X"
```

```ruby
set :project_url,     "https://github.com/company/project_x"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/capistrano-skype/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
