[{ email: "mostafa@gmail.com", password: 123_123 }].each do |admin|
  unless AdminUser.exists?(email: admin[:email])
    AdminUser.create!(admin.merge(password_confirmation: admin[:password]))
  end
end

if Rails.env.development?
  Rake::Task["populate:test_users"].invoke if User.count.zero?
  Rake::Task["populate:test_cars"].invoke if Car.count.zero?
  Rake::Task["populate:test_problems"].invoke if Problem.count.zero?
end
