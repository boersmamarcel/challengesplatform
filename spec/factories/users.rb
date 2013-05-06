FactoryGirl.define do
  factory :user do |u|
    u.email "default"
    u.password  "default123"
    u.password_confirmation "default123"
    u.role "0"
  end
end
