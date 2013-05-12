FactoryGirl.define do
  factory :user do |u|
    u.email "participant@student.utwente.nl"
    u.password  "default123567"
    u.password_confirmation "default123567"
    u.role 0
  end
end
