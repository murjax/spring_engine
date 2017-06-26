require "spec_helper"

RSpec.describe SpringEngine do
  it "generates config and bin files in appropriate folders" do
    `bundle exec spring_engine spec/dummy`
    expect(File.exist?("bin/rails")).to eq(true)
    expect(File.exist?("bin/rake")).to eq(true)
    expect(File.exist?("bin/spring")).to eq(true)
    expect(File.exist?("config/spring.rb")).to eq(true)

    `rm config/spring.rb`
    `rm bin/spring`
  end
end
