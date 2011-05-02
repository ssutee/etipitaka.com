require 'faker'

Factory.define :page do |page|
  page.language     'thai'
  page.volume       1
  page.number       1
  page.content      Faker::Lorem.sentence(20)
end
