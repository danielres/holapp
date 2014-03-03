# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do

    password 'changeme'
    password_confirmation 'changeme'
    confirmed_at Time.now

    factory :no_roles_user do
      name 'New user'
      email 'regular@example.com'
    end

    factory :super_user do
      name 'Superuser'
      email 'super@example.com'
      after(:create) {|user| user.add_role(:admin)}
    end

  end


end
