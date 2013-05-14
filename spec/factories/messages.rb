FactoryGirl.define do
  factory :message do |m|
    m.subject 'A title'
    m.body 'A long lipsum body'
    m.is_read 0
  end
end
