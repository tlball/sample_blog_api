FactoryGirl.define do

  factory :post do
    title 'Flintsones meet the Jetsons'
    content 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    association :creator, factory: :user
  end


  # user factory without associated posts
  factory :user do
    first_name 'Fred'
    last_name  'Flintstone'
    email { "#{first_name}.#{last_name}@bedrock.com".downcase }
  end

  factory :category do
    name 'Food'
  end
end