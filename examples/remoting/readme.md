# Remoting

Remote service execution is one of the cool features built within the rDDD framework, which would unobtrusively allow 
you, to split your application into multiple pieces as you
go.

Because all the services are executed through the service bus
you are able to detach subset of your application services
to its separate server instance without any further changes
to your client code or services themselves. All you need to
do is to configure the namespaces and endpoints, so framework
knows where to find the remote instance.

Example consists of two Sinatra applications. ```Remote``` is the remote instance with (dummy) domain logic. ```App``` is the main application which calls service from the remote. 

## Run example

Open first console:

  cd examples/remoting/remote/
  bundle
  rackup -p 9393

Open other console:

  cd examples/remoting/app/
  bundle
  rackup

Now you can access ```http://localhost:9292/``` which would load json document from the remote instance. Try ```http://localhost:9292/?name=Rails``` which filter the output. All the logic is in ```remoting/remote/services/list_service.rb```.

