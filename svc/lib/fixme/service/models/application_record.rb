# frozen_string_literal: true

require 'rolify'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  establish_connection(ENV['RACK_ENV'].to_sym)

  extend Rolify
end
