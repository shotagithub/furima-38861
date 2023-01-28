FactoryBot.define do
  factory :user do
    nick_name               { Faker::Name.initials }
    email                   { Faker::Internet.free_email }
    password                { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation   { password }
    family_name             { '田中' }
    first_name              { '太郎' }
    family_name_ruby        { 'タナカ' }
    first_name_ruby         { 'タロウ' }
    birth_date              { Faker::Date.birthday }
  end
end
