require "jennifer"
require "jennifer/adapter/postgres"

APP_ENV = "development"

Jennifer::Config.read("config/database.yml", APP_ENV)

Log.setup "db", :debug, Log::IOBackend.new(formatter: Jennifer::Adapter::DBFormatter)
