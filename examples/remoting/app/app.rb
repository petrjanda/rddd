require 'sinatra'
require 'rddd'
require 'rddd/services/service_bus'

Rddd.configure do |config|
  config.remote_services = [
    {:namespace => :projects, :endpoint => 'http://localhost:9393/service/'}
  ]
end

class App < Sinatra::Base
  include Rddd::Services::ServiceBus

  get '/' do
    name = params[:name]
    body = name ? {:name => name} : {}
    @data = execute_service(:projects__list, body)

    erb :projects
  end
end