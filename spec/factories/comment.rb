FactoryGirl.define do
  factory :comment do |c|
    c.user_id 1
    c.challenge_id 1
    c.comment "Sample comment"
    c.updated_at Time.now
  end
end
