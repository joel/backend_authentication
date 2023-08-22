# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = FactoryBot.create(:user, name: "John", email: "john.doe@acme.com", password: "123456", password_confirmation: "123456")

"A".upto("E") do |letter|
  project = FactoryBot.create(:project, name: "Project #{letter}", user:)
  5.times do |_i|
    FactoryBot.create(:deliverable, name: "Deliverable #{letter}", project:)
  end
end

%w[Peter Steven Karl].each do |name|
  user = FactoryBot.create(:user, name:, email: "#{name.downcase}@acme.com", password: "123456", password_confirmation: "123456")
  last_project = Project.last
  cursor = last_project.name.match(/Project ([A-Z])/)[1]
  5.times do |_i|
    next_letter = cursor.next
    project = FactoryBot.create(:project, name: "Project #{next_letter}", user:)
    5.times do |_i|
      FactoryBot.create(:deliverable, name: "Deliverable #{next_letter}", project:)
    end
    cursor = next_letter
  end
end
