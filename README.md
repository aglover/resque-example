# Rescue sample project 


This project uses [RedisToGo.com](https://redistogo.com) for Redis and [MongoHQ.com](https://mongohq.com) for MongoDB. The project is simple -- the `DealsEndpoint` class creates a record in MongoDB with raw coordinates. After inserting a document, a background job is queued -- this job, dubbed `ReverseGeocoder` takes the coordinates and reverse geocodes them into a valid address. The corresponding document in MongoDB is then updated.

## Installation

This is a simple project to demonstrate [Resque](https://github.com/defunkt/resque) -- to use it, simply run `bundle install` and then run `rake` (which runs the test task) so as to verify things are working. This project assumes Ruby version 1.9.2.

To place some items on a queue, via the command line, run `bundle exec ruby lib/deals_endpoint.rb -a 39.1155556 -b -77.5638889 -d "Free Beer and beans and kids"` -- note, you can put any valid coordinate for `-a` or `-b` and the `-d` is just a description. Next, to pop what ever you've placed onto a queue, run in another command prompt: `bundle exec rake resque:work QUEUE=reverse_geocode`

# License

The MIT License

Copyright (c) 2011 App47, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE