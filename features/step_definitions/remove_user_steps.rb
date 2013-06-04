Then(/^the challenges of supervisor with id "(.*?)" should be transferred to the default supervisor$/) do |user_id|
	Challenge.where(:supervisor_id => user_id).count.should eql 0
end