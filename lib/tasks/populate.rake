namespace :populate do
  desc "Initial populate"

  task test_users: :environment do
    puts "Populating test users..."

    Users::Member.create!(
      first_name: "Mostafa",
      last_name: "Member",
      email: "mostafa@member.com",
      password: "123123"
    )

    Users::Technician.create!(
      first_name: "Ali",
      last_name: "Technician",
      email: "ali@technician.com",
      password: "123123"
    )
    puts "Test users populated"
  end

  task test_cars: :environment do
    puts "Populating test cars..."

    Users::Member.first.cars.create!(
      name: "Mercedes",
      plate_number: "ABC123",
      color: "Red",
      brand: "Mercedes",
      model: "GLE",
      year: 2020
    )
    puts "Test cars populated"
  end

  task test_problems: :environment do
    puts "Populating test problems..."

    Users::Member.all.sample.cars.sample.problemize("Engine Failure")

    puts "Test problems populated"
  end
end
