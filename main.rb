require 'bundler'
Bundler.require
require 'sinatra'

require_relative 'schema'
require_relative 'omniauth'
require_relative 'helpers'
require_relative 'posts'
require_relative 'users'