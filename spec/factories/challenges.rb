FactoryGirl.define do
  factory :challenge do
   id 1
   title "Default title"
   description "Default description"
   start_date Date.today + 2
   end_date Date.today + 4
   state "proposal"
   count 0
  end
end
