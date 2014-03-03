FactoryGirl.define do

  factory :person, class: :user do
    name 'Person name'
    email 'person@example.com'
    password 'changeme'
    password_confirmation 'changeme'
  end

end
