- 主導で叩くtask処理は動く
- Wheneverは動いててlogは吐き出してくれているが延々エラー
```
/System/Library/Frameworks/Ruby.framework/Versions/2.6/usr/lib/ruby/2.6.0/rubygems.rb:283:in `find_spec_for_exe': Could not find 'bundler' (2.3.5) required by your /Users/akinari/src/github.com/akinari0919/gantobashi/Gemfile.lock. (Gem::GemNotFoundException)
To update to the latest version installed on your system, run `bundle update --bundler`.
To install the missing version, run `gem install bundler:2.3.5`
        from /System/Library/Frameworks/Ruby.framework/Versions/2.6/usr/lib/ruby/2.6.0/rubygems.rb:302:in `activate_bin_path'
        from /usr/bin/bundle:23:in `<main>'
```
- 指示コマンドは実施済みでGemfile.lockに記載のbundlerさんは2.3.5
- rubyのバージョンは3.0.3やから2.6.0ってなってるのがおかしい？
- 普段使っている Ruby と cron で起動する Ruby が異なるかも?
```
set :path_env, ENV['PATH']
```
を`config/schedule.rb`に記載
- `bundle exec whenever --update-crontab`実行、、、
変わらん。。

引き続きチャクラ練る
