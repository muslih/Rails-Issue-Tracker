require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.first_name            { Faker::Name.first_name }
    f.last_name             { Faker::Name.last_name }
    f.email                 { Faker::Internet.email }
    f.password              'password'
    f.password_confirmation 'password'
    
    factory :admin do
      role 'admin'
    end

    factory :technician do
      role 'technician'
    end

    factory :customer do
      role 'customer'
    end
  end
end
