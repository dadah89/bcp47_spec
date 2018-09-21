# bcp47_spec [![Build Status](https://travis-ci.org/dadah89/bcp47_spec.svg?branch=master)](https://travis-ci.org/dadah89/bcp47_spec)
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
BCP47.valid?('de-Latn-DE-1996-u-attr-co-phonebk-t-und-cyrl-x-private-test') # true
```

```ruby
tag = BCP47.parse('de-Latn-DE-1996-u-attr-co-phonebk-t-und-cyrl-x-private-test')
tag.language  # de
tag.script    # Latn
tag.region    # DE
tag.variant   # [1996]
tag.extension # [['t', 'und-cyrl'], ['u', 'attr-co-phonebk']]
tag.private   # ['private', 'test']
```

```ruby
BCP47.parse('blahblahblah') # raises InvalidLanguageTag
```

## TODO

* Parse extensions T (https://tools.ietf.org/html/rfc6497) and U (https://tools.ietf.org/html/rfc6067)
