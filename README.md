# SpringEngine

SpringEngine is a configuration utility for setting up Spring on a Rails engine.
## Installation

Add `spring_engine`, `spring`, and any other spring command gems to your Rails engine Gemfile and bundle

```ruby
gem 'spring'
gem 'spring_engine'
```
    $ bundle


## Usage

First ensure your engine has a test app. You may create one manually or use a generator such as EngineCart.

Now in the root directory of your Rails engine, execute the following with the path to your test app:
```
    $ bundle exec spring_engine *path_to_dummy_folder*
```
SpringEngine runs `spring binstub --all` for you. You are now ready to use Spring.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/murjax/spring_engine.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
