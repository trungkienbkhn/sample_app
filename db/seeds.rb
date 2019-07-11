User.create!(name: Figaro.env.admin_name,
             email: Figaro.env.admin_email,
             password: Figaro.env.admin_pass,
             password_confirmation: Figaro.env.admin_pass_confirmation,
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
