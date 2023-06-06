FactoryBot.define do
  factory :user do
    name { 'name' }
    email { 'email@gmail.com' }
    password { 'password' }
    
    trait :manager do
      role { 'manager' }
    end
    
    trait :member do
      role { 'member' }
    end
  end
end
