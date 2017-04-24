namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(username: "Example User",
                  last_name: "User",
                  first_name: "User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      username  = Faker::Name.name
      email = Faker::Internet.email
      password  = "password"
      User.create!(username: username,
                    last_name: "User",
                    first_name: "User",
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    50.times do
      title = Faker::Lorem.sentence(1)
      body = Faker::Lorem.sentence(5)
      users.each { |user| user.posts.create!(body: body, title: title) }
    end
  end
end