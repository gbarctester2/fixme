# frozen_string_literal: true

root = File.expand_path('..', __dir__)
rackup "#{root}/config.ru"

port ENV['PORT'] || 3030
environment ENV['RACK_ENV'] || 'development'
