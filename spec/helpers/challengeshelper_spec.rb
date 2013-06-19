require_relative '../spec_helper'

describe ChallengesHelper do 
	include Devise::TestHelpers

	before (:each) do
		@user = FactoryGirl.create(:user)
		sign_in @user

		@challenge = FactoryGirl.create(:challenge)
		@challenge2 = FactoryGirl.create(:challenge, :title => "different title")

		@challenge.participants << @user
	end

	it "should recognize when a user is enrolled" do
		helper.enrolled?.should be_true
		@challenge = @challenge2
		helper.enrolled?.should be_false
	end
	
	it "should show a warning icon when state is declined" do
	  @challenge.decline
	  @challenge.count += 1
	  helper.state_icon_class(@challenge).should == "icon-warning-sign"
  end
end