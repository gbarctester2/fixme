# frozen_string_literal: true

require './config/setup'
$LOAD_PATH.unshift 'lib'

require 'fixme/service/app'

run Service::App.new
