# future.rb

A simple concurrent [futures](https://en.wikipedia.org/wiki/Futures_and_promises) library for Ruby.

Futures are a simple construct that make it easier to write concurrent/asynchronous programs. As an example of their use, here's a dead simple concurrent web crawler using future.rb:

```ruby
require "future"
require "open-uri"

def fetch_url(url)
  Future { open(url).read }
end

def crawl_urls(urls)
  Future.all(urls.map {
    fetch_url(url)
  })
end

results = crawl_urls([
  "http://google.com/",
  "http://twitter.com/",
  "http://github.com/",
]).value
```

Notice that instead of returning values directly, the methods in the code above return `Future` instances. Because in-progress computation or I/O is represented as a value, we can apply the same reasoning to code dealing with futures as we can with code dealing with the values themselves.

## API

future.rb's core API is very small and easy to understand.

`Future.new { code }` (or `Future { code }`) creates a new future object representing the value computed by the code in the block. This method returns immediately while the computation is performed asynchronously.

When the computation performed by the future blocks on I/O, future.rb automatically starts running other code (including other futures) while waiting for that I/O to complete. This approach to concurrency is quite similar to that used by node.js - but with none of the callback hell!

When your program needs the value of a `Future` instance, just call the `value` method. If the future has completed, this method will return immediately. If the future is still in the process of performing computation or I/O, future.rb will wait for it to complete before returning. The library cleverly makes use of this time spent waiting on futures to complete by running other code/futures in the meantime!

If a future has failed, `value` will raise the failing exception when called. This approach to error handling results in far less boilerplate than more manual approaches, such as 'errbacks' (error callbacks) or explicit error return values.

Finally, the `Future.all` helper method can be used to convert an array of futures into a future of an array of values. For example:

```ruby
futures = [
  Future { 123 },
  Future { 456 },
  Future { 789 },
]

Future.all(futures).value # => [123, 456, 789]
```

## Installation

Add the following line to your `Gemfile`:

```ruby
gem "future.rb"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

[MIT](https://github.com/charliesome/future.rb/blob/master/LICENSE)
