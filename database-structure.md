### This is a database structure to simulate a car fixing system for Mercedes.

# User

# Member < User:
- has_many: cars

# Technician < User:
- has_many: fixing_cars

# Car:
- belongs_to: member
- has_many: fixing_cars

# Solution:
- belongs_to: problem
- has_many: part_usages

# Problem:
- belongs_to: fixing_car
- has_one: solution

# FixingCar:
> join table between Car and Technician

- belongs_to: car
- belongs_to: technician
- has_one: problem
- has_many: part_usages

# Part:
- has_many: part_usages

# PartUsage:
- belongs_to: part
- belongs_to: solution