module SpringEngine
  class Configure

    def self.configure_spring_for_engine(path_to_dummy)
      require 'pry'; binding.pry;

      path = path_to_dummy.first
      FileUtils.mkdir("config") unless File.exists?("config")

      File.open("config/spring.rb", "w") do |file|
        file.puts "Spring.application_root='#{path_to_dummy}'"
      end

      `bundle exec spring binstub --all`
      FileUtils.mkdir("bin") unless File.exists?("bin")

      `cp -r #{path}/bin/rake bin/rake`
      `cp -r #{path}/bin/spring bin/spring`
      `cp -r #{path}/bin/rspec bin/rspec` if File.exists?("#{path}/bin/rspec")
      `cp -r #{path}/bin/cucumber bin/cucumber` if File.exists?("#{path}/bin/cucumber")
      `cp -r #{path}/bin/spinach bin/spinach` if File.exists?("#{path}/bin/spinach")
      `cp -r #{path}/bin/testunit bin/testunit` if File.exists?("#{path}/bin/testunit")
      `cp -r #{path}/bin/teaspoon bin/teaspoon` if File.exists?("#{path}/bin/teaspoon")
      `cp -r #{path}/bin/m bin/m` if File.exists?("#{path}/bin/m")
      `cp -r #{path}/bin/rubocop bin/rubocop` if File.exists?("#{path}/bin/rubocop")

      File.open("bin/rails", "w") do |file|
        file.puts "#!/usr/bin/env ruby
# This command will automatically be run when you run 'rails' with Rails gems
# installed from the root of your application.
begin
  load File.expand_path('../spring', __FILE__)
rescue LoadError => e
  raise unless e.message.include?('spring')
end
ENGINE_ROOT = File.expand_path('../..', __FILE__)
ENGINE_PATH = File.expand_path('../../lib/#{File.basename(Dir.getwd)}/engine', __FILE__)

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

require 'rails/all'
require 'rails/engine/commands'"
      end
    end
  end
end
