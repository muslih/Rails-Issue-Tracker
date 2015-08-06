require 'faker'

FactoryGirl.define do
  factory :ticket do |f|
    f.title       { Faker::Lorem.sentence }
    f.issue_type  { ['software', 'equipment', 'computer', 'peripheral', 'network'].sample }
    f.status      { ['open', 'in progress', 'pending customer response',
                     'contact customer', 'closed'].sample }
    f.priority    { rand(1..5) }
  end

end
