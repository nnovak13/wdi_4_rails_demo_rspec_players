FactoryGirl.define do
  factory :player do
    name { Faker::Name.first_name }
    job { JOBS::Player }
    health { rand(100) + 50}
    magic { rand(100) + 50}
  end
end
