# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl'
require 'faker'
groups = %w{software equipment desktop network helpdesk admin}

admin = User.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password',
                    first_name: 'Admin', last_name: 'Example', role: 'admin')

groups.each do |group|
  Group.create(name: group)
end

admin.add_group('admin')
admin.add_group('software')

(1..10).each do
  c = FactoryGirl.create(:customer)
  c.save
    (1..5).each do
      tick = c.tickets.create(FactoryGirl.attributes_for(:ticket))
      tick.add_group(tick.issue_type)
    end

    c.tickets.each do |ticket|
      i = ticket.issues.create(description: Faker::Lorem.paragraph(3), user_id: c.id)
      i.user_id = c.id
    end
  t = FactoryGirl.create(:technician)
  t.save
    (1..5).each do
      tick = t.tickets.create(FactoryGirl.attributes_for(:ticket))
      tick.add_group(tick.issue_type)
    end

    t.tickets.each do |ticket|
      i = ticket.issues.create(description: Faker::Lorem.paragraph(3), user_id: t.id)
      i.user_id = c.id
    end
  a = FactoryGirl.create(:admin)
  a.save
    (1..5).each do
      tick = a.tickets.create(FactoryGirl.attributes_for(:ticket))
      tick.add_group(tick.issue_type)
    end

    a.tickets.each do |ticket|
      i = ticket.issues.create(description: Faker::Lorem.paragraph(3), user_id: a.id)
      i.user_id = a.id
    end
end

