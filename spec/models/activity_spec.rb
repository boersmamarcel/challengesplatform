require_relative '../spec_helper.rb'

describe Activity do
  
  it "should remove old activities" do
    Activity.all.count.should == 0
    
    for i in 0..10
      FactoryGirl.create(:activity, :created_at => i.days.ago)
    end
    
    Activity.all.count.should == 11
    Activity.delete_old_records
    Activity.all.count.should == 7
  end
  
end