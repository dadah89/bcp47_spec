# bcp47_spec
A subset of the BCP 47 spec: https://tools.ietf.org/html/bcp47

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zendesk_i18n_dev_tools'
```

And then execute:
```
$ bundle
```

Or install it yourself as:
```
$ gem install zendesk_i18n_dev_tools
```

## Usage

```ruby
BCP47.valid?('de-Latn-DE-1996-x-private-test') # true
```

```ruby
tag = BCP47.new('de-Latn-DE-1996-x-private-test')
tag.language  # de
tag.script    # Latn
tag.region    # DE
tag.variant   # [1996]
tag.extension # []
tag.private   # private-test
```

```ruby
BCP47.new('blahblah') # raises InvalidLanguageTag
```
