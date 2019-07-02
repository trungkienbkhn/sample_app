User.create!(name: ENV["ADMIN_NAME"],
             email: ENV["ADMIN_EMAIL"],
             password: ENV["ADMIN_PASS"],
             password_confirmation: ENV["ADMIN_PASS_CONFIRMATION"],
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
