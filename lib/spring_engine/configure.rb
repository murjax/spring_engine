module SpringEngine
  class Configure

    def initialize(path_to_dummy)
      @path = path_to_dummy.first
    end

    def configure_spring_for_engine
      write_spring_config
      exec_spring_binstub
      copy_dummy_bin
      write_bin_rails
    end

    def exec_spring_binstub
      `bundle exec spring binstub --all`
    end

    def copy_dummy_bin
      FileUtils.mkdir("bin") unless File.exists?("bin")
      copy_standard_commands
      copy_optional_commands
    end

    def copy_standard_commands
      standard_commands = ['rake', 'spring']
      standard_commands.each do |command|
        `cp -r #{@path}/bin/#{command} bin/#{command}`
      end
    end

    def copy_optional_commands
      optional_commands = ['rspec', 'cucumber', 'spinach', 'testunit', 'teaspoon', 'm', 'rubocop']
      optional_commands.each do |command|
        `cp -r #{@path}/bin/rspec bin/#{command}` if File.exists?("#{@path}/bin/#{command}")
      end
    end

    def write_spring_config
      FileUtils.mkdir("config") unless File.exists?("config")

      File.open("config/spring.rb", "w") do |file|
        file.puts "Spring.application_root='#{@path}'"
      end
    end

    def write_bin_rails
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
