# frozen_string_literal: true

$LOAD_PATH.unshift 'lib'

require 'active_record'
require 'fixme/service'

ENV['RACK_ENV'] || ENV['ENV']

$stdout.sync = true
Bundler.require(:default, ENV['RACK_ENV'])

loader = Zeitwerk::Loader.new
loader.push_dir('./lib')
loader.push_dir('./lib/fixme/service/models')
loader.setup

db_config = 'config/database.yml'

raise "no #{db_config} !" unless File.file?(db_config)

ActiveRecord::Base.configurations = YAML.safe_load(ERB.new(File.read(db_config)).result, aliases: true) || {}
ActiveRecord.default_timezone = :utc
ActiveRecord::Base.establish_connection
