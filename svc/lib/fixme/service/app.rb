# frozen_string_literal: true

require 'sinatra'
require 'rack'
require 'rack/contrib/jsonp'
require 'rack/contrib/json_body_parser'
require 'fixme/service/syncer'

module Service
  class App
    attr_accessor :app

    autoload :Api, 'fixme/service/app/api'

    Rack.autoload :SSL, 'rack/ssl'

    def self.new(_options = {})
      super()
    end

    def initialize
      @app = Rack::Builder.app do
        use Rack::Deflater
        use Rack::JSONBodyParser
        use Rack::JSONP

        map('/') { run(Api.new) }
      end
    end

    def call(env)
      app.call(env)
    end
  end
end
