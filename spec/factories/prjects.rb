FactoryBot.define do
  factory :project do
    name { 'Sample Project' }
    description { 'Sample Project Description' }
    association :creator, factory: :user
  end
end
