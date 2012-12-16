rddd
====

## Code quality check

![rDDD@sniffer](https://sniffer.io/info/public-project-135230969156499600)

Ruby DDD (Domain Driven Development) framework

Intention of rddd is to provide basic skeleton for DDD ruby application. Its framework agnostic, although some framework specific extensions might come later to make it easier to start.

## Key goals

* Provide basic DDD elements
* Support separation of domain from delivery mechanism (mostly web framework such Rails or Sinatra)
* Support separation of domain from persistancy mechanism

## Basic architecture

![Architecture overview](https://github.com/petrjanda/rddd/blob/master/documentation/rddd.png?raw=true)

There are two major entry points to the domain layer from the delivery mechanism. Service bus, for a command execution and 
Presenter factory, to build up the presented business data (views / reports).

### Service bus

To further enhance the separation of delivery mechanism and domain from each other, every call to the domain service is done through the ```Service bus```. The key design goal is to decouple concrete service implementation from the non-domain code, so they never have to be directly instantiated outside the domain itself. Instead, service bus defines simple protocol for any object, which can call its ```execute``` method with service name and parameters. The instantiation of the service object then becomes implementation detail of domain code, thus leaves the flexibility for alternative solutions within domain.

In Rails application, it might look like:

    class ProjectsController < ApplicationController
      include ServiceBus

      def create
        execute(:create_project, params) do |errors|
          render :new, :errors => errors
          return
        end

        redirect_to projects_path, :notice => 'Project was successfully created!'
      end
    end 

### Presenter factory

We dont wanna DM (Delivery mechanism) know too much about domain implementation internals. Neither about specific presenter classes. We apply same approach as for Service bus and define simple interface to load a specific view.

In Rails application, it might be used as:

    class ProjectsController < ApplicationController
      def index
        PresenterFactory.build(:projects_by_account, :account_id => params[:account_id])
      end
    end

### Services

Service is the object to represent a single use case. Its responsibility is to orchestrate the cooperation of multiple aggregate roots (and entities), in a given order defined by use case.

Service takes a list of attributes, which are necessary to execute the given use case. At the end nothing is returned, so service represent the command to the domain and doesn't return any data back. Therefore, client code should construct and pass all the data for the given use case and keep them, so it doesn't have to use presenters to load the result of the operation back.

### Presenters

Presenter is the view to the domain data, which is typically aggregation over multiple aggregate roots and entities. In other
language presenter is report. In Rddd, views output plain Ruby hashes, thus no domain object is leaking outside the domain
itself. The key design goal was to dont let framework later call any additional adhoc methods. Thats why framework doesn't interact with view object directly and pure Hash is returned back.

### Aggregate root, entity, repository

TBA

## Planned features

* Asynchronous notifications from services - Services might be executed synchronous but also asynchronous way. Simple extension of Service bus would do the trick (add ```execute_async``` method). Its a common case that client code might
be waiting for the result from background job execution so it can talk back to user. There is a plan to add ```Notifier``` interface, which would be available during service execution. This interface should get concrete implementation within delivery mechanism (websockets, ...).

## Project file structure

Recommented project file structure:

    app/entities
    app/repositories
    app/services

## Author(s)

* Petr Janda ([petr@ngneers.com](mailto:petr@ngneers.com))

Wanna participate? Drop me a line.

## License

Copyright (c) 2012 Petr Janda

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.