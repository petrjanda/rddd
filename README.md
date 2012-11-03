rddd
====

Ruby DDD (Domain Driven Development) framework

Intention of rddd is to provide basic skeleton for DDD ruby application. Its framework agnostic, although some framework specific extensions might come later to make it easier to start.

## Key goals

* Provide basic DDD elements
* Support separation of domain from delivery mechanism (MVC framework)
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

## Project structure

Recommented project file structure:

    app/entities
    app/repositories
    app/services