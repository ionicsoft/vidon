source 'https://rubygems.org'

gem 'rails',                   '~> 5.2'
gem 'bcrypt',                  '3.1.12'
gem 'faker',                   '1.7.3'
gem 'mini_magick',             '4.7.0'
gem 'will_paginate',           '3.1.6'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'bootstrap',               '~> 4.3.1'
gem 'puma',                    '~> 3.12.4'
gem 'uglifier',                '>= 3.2.0'
gem 'coffee-rails',            '~> 4.2.2'
gem 'jquery-rails',            '~> 4.3.1'
gem 'turbolinks',              '5.0.1'
gem 'jbuilder',                '~> 2.7.0'
gem "font-awesome-rails"
gem 'sass'

group :development, :test do
  gem 'sqlite3', '~> 1.3.13'
  gem 'byebug',  '9.0.6', platform: :mri
  gem 'rspec-rails', '~> 3.8'
end

group :development do
  gem 'web-console',           '>= 3.5.1'
  gem 'listen',                '>= 3.1.5', '< 3.2'
  gem 'spring',                '>= 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.1'
end

group :test do
  gem 'capybara',                 '~> 2.13'
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest',                 '5.10.3'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '>= 2.14.1'
  gem 'guard-minitest',           '>= 2.4.6'
  gem 'selenium-webdriver'
  gem 'geckodriver-helper', '~> 0.0.3'
end

group :production do
  gem 'mysql2',  '~> 0.4.4'
  gem "aws-sdk-s3", require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
