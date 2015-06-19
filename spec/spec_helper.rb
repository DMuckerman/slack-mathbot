$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'rubygems'
require 'rspec'
require 'rack/test'

require 'config/environment'
require 'slack-mathbot'

Dir[File.join(File.dirname(__FILE__), 'support', '**/*.rb')].each do |file|
  require file
end
