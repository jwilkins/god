# For Twitter updates you need the 'twitter' gem
#   (gem install twitter)
#
# Configure your watches like this:
#
#   God::Contacts::Twitterer.settings = { :username => 'sender@example.com',
#                                       :password  => 'secret' }
#   God.contact(:twitterer) do |c|
#     c.name      = 'Tester'
#     c.group     = 'developers'
#   end

require 'rubygems'
require 'twitter'

module God
  module Contacts
    class Twitterer < Contact
      class << self
        attr_accessor :settings
      end

      def valid?
        valid = true
      end

      def notify(message, time, priority, category, host)
        begin
          Twitter::Base.new(Twitterer.settings[:username], 
                            Twitterer.settings[:password]).update(message)

          self.info = "sent twitter update as #{Twitterer.settings[:username]}"
        rescue => e
          self.info = "failed to send twitter update from #{self.twitter_id}: #{e.message}"
        end
      end
    end
  end
end
