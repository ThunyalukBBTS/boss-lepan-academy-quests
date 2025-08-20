# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Quest.create!([
  {
    name: "Onbording",
    is_done: true,
  },
  {
    name: "Scrum Class",
    is_done: true,
  },
  {
    name: "Ruby Class",
    is_done: true,
  },
  {
    name: "Ruby On Rails Class",
    is_done: true,
  },
  {
    name: "Git Class",
    is_done: true,
  },
  {
    name: "Agile Testing Class",
    is_done: false,
  },
  {
    name: "Playwright Testing",
    is_done: false,
  },
  {
    name: "Docker Class",
    is_done: true,
  },
  {
    name: "GitLab CI Class",
    is_done: true,
  },
  {
    name: "Jenkins Class",
    is_done: true,
  },
  {
    name: "Quest: พิมพ์ดีด 55 คำ ต่อนาที 95%",
    is_done: true,
  },
  {
    name: "Quest: Scrum Assessment",
    is_done: true,
  },
  {
    name: "Academy Final Test",
    is_done: false,
  },
  {
    name: "Quest: Git assessment",
    is_done: true,
  },
  {
    name: "Quest: Code Kata",
    is_done: true,
  },
  {
    name: "Quest: ส่ง baseline ออกกำลังกายที่นี่",
    is_done: true,
  }
])