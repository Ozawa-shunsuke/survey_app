# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Examples User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

19.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end 

users = User.order(:created_at).take(15)
15.times do
 text = Faker::Lorem.sentence(1)
 title = Faker::Lorem.sentence(1)
 name1  = Faker::Book.genre
 name2 = Faker::Book.genre
 users.each { |user| user.posts.create!(title: title,
                                        description: text,
                                        choice_1: name1,
                                        choice_2: name2) }
end

#15.times do |n|
 #   random = Random.rand(1 .. 2)
    #n += 1
  #  Result_Post.create!(user_id: n,
   #                    post_id: n,
    #                   choice_id: random)
#end

Result_Post.create do |u|
  u.choice_id = 1
  Result_Post.create!(choice_id: u.choice_id)
end
