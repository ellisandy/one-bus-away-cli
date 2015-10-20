# OneBusAway

This little 'gem' is for easily querying the next available bus at a given stop.

## Pre-reqs

Please have the ruby development packaged installed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'one_bus_away'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install one_bus_away

Then you will need to create the file ~/.one_bus_away which contains just your API key which can be requested here: http://pugetsound.onebusaway.org/p/OneBusAwayApiService.action

    $ cat ~/.one_bus_away
	6xxxxxf7-6ec4-45adsf22-bf33-sdfsdfs


## Usage


one-bus-away arrivals-and-departures-for-stop [stop] [route] [arrival time from now]

    $ one-bus-away arrivals-and-departures-for-stop 13721 "D Line" 22
      The D Line arrives in 4 minutes
      The D Line arrives in 19 minutes

## Contributing

1. Fork it ( https://github.com/ellisandy/one-bus-away-cli/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
