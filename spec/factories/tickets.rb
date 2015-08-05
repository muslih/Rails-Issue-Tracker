require 'faker'

FactoryGirl.define do
  factory :ticket do |f|
    f.title       { Faker::Lorem.sentence }
    f.issue_type  'software'
    f.status      'open'
    f.priority    1
  end

end
