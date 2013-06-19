require_relative '../spec_helper'

describe ChallengeDecorator do
  it "should show 0 when there a challenge is not upcoming" do
    challenge = FactoryGirl.create(:challenge)
	  challenge.start_date = Date.yesterday
	  ChallengeDecorator.new(challenge).days_till_start.should == 0
  end
end