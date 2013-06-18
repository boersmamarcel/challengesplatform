FactoryGirl.define do
  factory :challenge do |c|
   c.title "Default title"
   c.lead "Aenean mattis tellus ac urna suscipit quis tempor nisi fringilla. Nulla ullamcorper, nisl eget lacinia mattis, nunc."
   c.description "Default description"
   c.start_date Date.today + 2
   c.end_date Date.today + 4
   c.location "Zilverling"
   c.state "draft"
   c.commitment 4
   c.count 0
   c.meetingtime Time.now
   c.updated_at Time.now
   # c.association :supervisor_id, :factory => :user
  end
end
