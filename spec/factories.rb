require 'faker'

Factory.define :user do |user|
  user.user_name              'test'
  user.email                  'test@foobar.com'
  user.password               'foobar'
  user.password_confirmation  'foobar'
end

Factory.define :page do |page|
  page.language     'thai'
  page.number       1
  page.volume       1
  page.content      'foobar barfoo'
end

Factory.define :item do |item|
  item.page_id    1
  item.number     1
  item.section    1
  item.begin      true
end
