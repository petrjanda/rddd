[rDDD@sniffer](https://sniffer.io/info/public-project-135230969156499600) - see the code quality on Sniffer.io

[![Build Status](https://travis-ci.org/petrjanda/rddd.png?branch=master)](https://travis-ci.org/petrjanda/rddd)

rddd
====

Ruby DDD (Domain Driven Development) framework

Intention of rddd is to provide basic skeleton for DDD ruby application. Its framework agnostic, although some framework specific extensions might come later to make it easier to start.

## Key goals

* Provide basic DDD elements
* Support separation of domain from delivery mechanism (mostly web framework such Rails or Sinatra)
* Support separation of domain from persistancy mechanism
* Make it easy to postpone decisions about background jobs processing or spliting the application into pieces

## Elements

![Elements](https://github.com/petrjanda/rddd/blob/master/documentation/rddd-elements.png?raw=true)

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