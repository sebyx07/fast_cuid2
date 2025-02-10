# FastCuid2 🚀

A high-performance CUID2 (Collision-resistant Unique ID) generator for Ruby, implemented in C for maximum speed while maintaining cryptographic security.

## What is CUID2? 🤔

CUID2 is the next generation of collision-resistant ids, designed to be:
- 🔒 Secure: Uses cryptographically secure random numbers
- 📏 Shorter: 24 characters vs CUID1's 25
- 🔗 URL-safe: Uses a restricted character set
- ⏰ Time-sortable: Includes a timestamp component
- 🎯 Unique: Has a negligible chance of collision

## Installation 💿

Add this line to your application's Gemfile:

```ruby
gem 'fast_cuid2'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install fast_cuid2
```

## Usage 🛠️

### Basic Usage 💡

```ruby
require 'fast_cuid2'

# Generate a new CUID2
id = FastCuid2.generate
puts id  # => "k2zt4qxvz5..."

# Use as a before_create callback in your models
class User < ApplicationRecord
  before_create :set_cuid2

  private
    def set_cuid2
      self.id = FastCuid2.generate
    end
end
```

### Database Migrations 🗄️

Example migration for creating a new table with CUID2:

```ruby
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: false do |t|
      t.string :id, primary_key: true, null: false, limit: 24
      t.timestamps
    end
  end
end
```

Adding a CUID2 column to an existing table:

```ruby
class AddReferenceToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :reference_id, :string, limit: 24
    add_index :posts, :reference_id, unique: true
  end
end
```

## CUID2 Format 📋

Each CUID2 is a 24-character string that:
- 📝 Always starts with a letter
- ⌨️ Uses only lowercase letters and numbers (excluding i, l, o, u)
- 🕒 Includes a time component for rough sorting
- 🔐 Has cryptographically secure random data

## Performance ⚡

FastCuid2 is implemented in C for maximum performance. It uses:
- 🔒 OpenSSL's CSPRNG for secure random numbers
- ⚙️ Optimized bit operations
- 💾 Minimal memory allocations
- 🔄 Thread-safe implementation

### Benchmarks 📊

Compared to the pure Ruby implementation (cuid2 gem), FastCuid2 shows significant performance improvements:

```
Single thread performance (10,000 iterations):
                           user     system      total        real
FastCuid2:             0.008065   0.001017   0.009082 (  0.009079)
Cuid2:                 1.993880   0.003501   1.997381 (  1.998460)

Detailed IPS (Iterations Per Second):
           FastCuid2:  1,232,654.8 i/s
               Cuid2:      5,087.0 i/s - 242.31x slower
```

Testing Environment:
- Ruby 3.4.1 with YJIT and PRISM
- Linux x86_64
- Both implementations maintain the same security guarantees and format specifications

## Development 👩‍💻

After checking out the repo, run:

```bash
$ bundle install
$ rake compile  # Builds the C extension
$ rake spec    # Runs the tests
```

## Contributing 🤝

Bug reports and pull requests are welcome on GitHub at https://github.com/sebyx07/fast_cuid2. This project is intended to be a safe, welcoming space for collaboration.

## License 📜

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct 🤝

Everyone interacting in the FastCuid2 project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/sebyx07/fast_cuid2/blob/master/CODE_OF_CONDUCT.md).