FactoryGirl.define do

  factory :person, class: :user do

    sequence(:name){ |n| "Person#{n} name" }
    sequence(:email){ |n| "person#{n}@example.com" }
    password 'changeme'
    password_confirmation 'changeme'
  end

end
