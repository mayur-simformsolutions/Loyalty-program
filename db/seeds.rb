# frozen_string_literal: true
require 'faker'

# Creating test user
user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: 'test@gmail.com', password: 'Simform@123',
                   date_of_birth: Faker::Date.in_date_period)
