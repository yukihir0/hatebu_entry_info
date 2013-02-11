# HatebuEntryInfo

'hatebu_entry_info' is ruby library for 'hatena bookmark entry information get API'.

## Requirements

- ruby 1.9
- json

## Install

Add this line to your application's Gemfile:

```
gem 'hatebu_entry_info', :github => 'yukihir0/hatebu_entry_info'
```

And then execute:

```
% bundle install
```

## How to use

```
url = 'http://www.hatena.ne.jp'

api = HatebuEntryInfo.new
@entry_info = api.get_json(url)
```

For more information, please see [here](https://github.com/yukihir0/hatebu_entry_info/blob/master/sample/main.rb).

## License

Copyright &copy; 2013 yukihir0
