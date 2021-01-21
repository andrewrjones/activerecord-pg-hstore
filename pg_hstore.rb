require 'bundler'
Bundler.setup(:default)

require 'active_record'
require 'logger'

ActiveRecord::Base.establish_connection(adapter: 'postgresql')
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  enable_extension 'hstore' unless extension_enabled?('hstore')
  create_table(:profiles, force: true) do |t|
    t.hstore 'settings', null: true
  end
end

class Profile < ActiveRecord::Base
end

Profile.create(settings: { "color" => "blue", "resolution" => "800x600" })

profile = Profile.first
profile.settings # => {"color"=>"blue", "resolution"=>"800x600"}

profile.settings = nil
profile.save!
