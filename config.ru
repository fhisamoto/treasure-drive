require 'bundler'
Bundler.require if defined?(Bundler)

require './web'

Web.run!