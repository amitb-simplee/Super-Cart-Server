#Todo use only this definition for mongoid rspec
RSpec.configure do |config|
  config.include Mongoid::Matchers, type: :model

end