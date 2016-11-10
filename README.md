# Playwright

Playwright is a foundational piece for building a test framework. It allows
test cases to be written as a play with all the moving parts to be categorized
as a `Stage`, `Scene`, `Props` or `Actor`.

### What are `Stage`, `Scene` or `Actor`?

Each test contains a single `Stage` which encapsulates one or many `Scene`s and
`Props`. There should only be one stage created in a test as it is the context
that everything should go through.

Once you have a `Stage` the next step is to create the `Scene`s that help build
the test or "story". A `Scene` groups two `Actor`s together that will
"interact" as the test runs. A `Stage` has multiple `Scene`s as there are
generally more than one action in a test.

An `Actor` will likely be a user in your system but it can be anything that
interacts another object type.

## Example

Let's imagine we have an platform with **sellers**, **buyers** and **fulfillment
agencies**. We need to create a test around fulfilling an order. You can teach
Playwright how to group actors together as **buyer** will only interact with
**seller** and **seller** will only interact with the **fulfillment agency**.

With Playwright you can build the entire `Stage` with all the expected `Scene`s
by simply providing the initial actor, which in this case is the **buyer**.

```ruby
stage = FulfillmentStage.new(:buyer)

# scenes
stage.scenes  #=> [Scene(:purchase_product), Scene(:fulfill_order)]
stage.current_scene #=> Scene(:purchase_product)
stage.fulfill_order!
stage.current_scene #=> Scene(:fulfill_order)

# actors
stage.actors #=> [:buyer, :seller, :fulfillment_agency]
stage.buyer   #=> User(username: 'buyer')
stage.seller  #=> User(username: 'seller')
stage.fulfillment_agency #=> FulfillmentAgency

# props
stage.products #=> [Product, Product, ...]
stage.orders #=> [Order, Order, ...]
```

The above code example is defined from the following.

```ruby
class FulfillmentStage < Playwright::Stage
  actors do
    actor(:buyer)   { User.find_by(username: 'buyer') }
    actor(:seller)  { User.find_by(username: 'seller') }
    actor(:fulfillment_agency) { FulfillmentAgency.find_by(name: 'agency-1') }
  end

  scenes do
    scene :purchase_product, from: :buyer, to: :seller
    scene :fulfill_order, from: :seller, to: :fulfillment_agency
  end

  prop_collection(:products) { |p| p.id }
  prop_collection(:orders) { |o| o.invoice_number }
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'playwright'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install playwright

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/baylorrae/playwright.

