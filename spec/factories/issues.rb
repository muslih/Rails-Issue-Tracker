require 'faker'

FactoryGirl.define do
  factory :issue do |f|
    f.description       { Faker::Lorem.paragraph(3) }
  end
end
