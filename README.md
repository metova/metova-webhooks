# Metova::Webhooks

Easily add webhooks to your Rails app.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'metova-webhooks'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install metova-webhooks

Then install the migrations:

    $ rake metova-webhooks:install:migrations

And migrate:

    $ rake db:migrate

### Notes

Webhooks requires a 'User' model and ActiveJob, so make sure you have those things.

## Usage

In your webhookable model, include `Metova::Webhookable`:

```ruby
class MyModel
  include Metova::Webhookable

  # the following overrides are optional and can be used to customize your events

  # override namespace to provide a namespace for your events (ex: a parent class and id)
  def namespace
    ''
  end

  # override hook_name to change the base event name
  def hook_name
    self.class.to_s.underscore
  end

  # override webhook_event to change how event names are constructed
  def webhook_event(event)
    [namespace, hook_name, event].reject(&:empty?).join(':')
  end

  # override webhook_serialize to change how the model is serialized for sending
  def webhook_serialize
    self.to_json
  end

  # ...
end
```

Include `Metova::WebhooksBase` in a controller:

```ruby
class MyWebhooksController < ActionController::Base
  include Metova::WebhooksBase

  # override create to change the create behavior
  def create
    # create takes a block, and the webhook will not save if there are any errors, so you can do custom validations
    super do |webhook|
      webhook.errors.add :user, "is not allowed to make webhooks" if some_condition
    end
  end

  protected
    # your controller needs to respond to current_user (for example, if you are using devise)
    def current_user
      nil
    end
end
```

Add routes to your `config/routes.rb`:

```ruby
resources :webhooks, only: [:index, :create, :destroy]
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/metova/metova-webhooks.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
