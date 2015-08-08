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
status = ['open', 'in progress', 'pending customer response', 'contact customer', 'closed']

admin = User.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password',
                    first_name: 'Admin', last_name: 'Example', role: 'admin')
tech = User.create(email: 'tech@example.com', password: 'password', password_confirmation: 'password',
                    first_name: 'Technician', last_name: 'Example', role: 'technician')
customer = User.create(email: 'customer@example.com', password: 'password', password_confirmation: 'password',
                    first_name: 'Customer', last_name: 'Example', role: 'customer')

groups.each do |group|
  Group.create(name: group)
end

admin.add_group('admin')
admin.add_group('software')

tech.add_group('helpdesk')

(1..10).each do
  c = FactoryGirl.create(:customer)
  c.save
    (1..5).each do
      tick = c.tickets.create(title: Faker::Lorem.sentence,
                              issue_type: %w{software equipment desktop network helpdesk}.sample,
                              status: status.sample,
                              priority: rand(1..5),
                              issues: [Issue.new(description: Faker::Lorem.paragraph(3))])
      tick.add_group(tick.issue_type)
    end

    # c.tickets.each do |ticket|
    #   i = ticket.issues.create(description: Faker::Lorem.paragraph(3), user_id: c.id)
    #   i.user_id = c.id
    # end
  t = FactoryGirl.create(:technician)
  t.save
    (1..5).each do
      tick = c.tickets.create(title: Faker::Lorem.sentence,
                              issue_type: %w{software equipment desktop network helpdesk}.sample,
                              status: status.sample,
                              priority: rand(1..5),
                              issues: [Issue.new(description: Faker::Lorem.paragraph(3))])
      tick.add_group(tick.issue_type)
    end

    t.tickets.each do |ticket|
      i = ticket.issues.create(description: Faker::Lorem.paragraph(3), user_id: t.id)
      i.user_id = c.id
    end
  a = FactoryGirl.create(:admin)
  a.save
    (1..5).each do
      tick = c.tickets.create(title: Faker::Lorem.sentence,
                              issue_type: %w{software equipment desktop network helpdesk}.sample,
                              status: status.sample,
                              priority: rand(1..5),
                              issues: [Issue.new(description: Faker::Lorem.paragraph(3))])
      tick.add_group(tick.issue_type)
    end

    a.tickets.each do |ticket|
      i = ticket.issues.create(description: Faker::Lorem.paragraph(3), user_id: a.id)
      i.user_id = a.id
    end
end

