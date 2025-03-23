[{ email: "mostafa@gmail.com", password: 123_123 }].each do |admin|
  unless AdminUser.exists?(email: admin[:email])
    AdminUser.create!(admin.merge(password_confirmation: admin[:password]))
  end
end
