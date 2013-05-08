FactoryGirl.define do
  factory :challenge do |c|
   c.title "Default title"
   c.description "Default description"
   c.start_date Date.today + 2
   c.end_date Date.today + 4
   c.state "proposal"
   c.count 0
   # c.association :user_id, :factory => :user
  end
end
