dir = "#{File.dirname(__FILE__)}/"
$LOAD_PATH.unshift(dir) unless $LOAD_PATH.include?(dir)

require 'sinatra'
require "sinatra/json"
require 'rddd'
require 'rddd/services/service_bus'

require 'services/list_service'

Rddd.configure do |config|
  config.service_creator = lambda do |name|
    class_name = "#{name.to_s.camel_case}Service"
    puts class_name
    Object.const_get(class_name.to_sym)
  end
end

class App < Sinatra::Base
  include Rddd::Services::ServiceBus

  post '/service/:service_name' do
    JSON.unparse(execute_service(params[:service_name], JSON.parse(request.body.read)))
  end
end