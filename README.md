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

As defined in DDD itself, framework has couple basic object types:

* Services - use cases
* Entities - domain objects with identity
* Aggregate roots - entities roots to setup consistency boundaries
* Repositories - abstraction over persistancy providing collections of aggregate roots

Alongside core DDD object types, there is couple supporting ones, mostly factories.

### Service bus

To further enhance the separation of delivery mechanism and domain from each other, every call to the domain service is done through the ```Service bus```. The key design goal is to decouple concrete service implementation from the non-domain code, so they never have to be directly instantiated outside the domain itself. Instead, service bus defines simple protocol for any object, which can call its ```execute``` method with service name and parameters. The instantiation of the service object then becomes implementation detail of domain code, thus leaves the flexibility for alternative solutions within domain.

## Project structure

Recommented project file structure:

    app/entities
    app/repositories
    app/services