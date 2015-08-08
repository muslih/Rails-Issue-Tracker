require 'faker'

FactoryGirl.define do
  factory :ticket do |f|
    f.title       { Faker::Lorem.sentence }
    f.issue_type  { %w{software equipment desktop network helpdesk}.sample }
    f.status      { ['open', 'in progress', 'pending customer response',
                     'contact customer', 'closed'].sample }
    f.priority    { rand(1..5) }
    f.issues      { [Issue.new(description: Faker::Lorem.paragraph(3))] }
  end

end
