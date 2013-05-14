require_relative '../spec_helper'

describe Enrollment do

  it "should not be possible to enroll in a challenge twice" do
    user = FactoryGirl.build(:user)
    challenge = FactoryGirl.build(:challenge)

    challenge.enroll(user).should be_an_instance_of(Enrollment)
    expect { challenge.enroll(user) }.to raise_error
  end

  it "should be possible to enroll, unenroll and enroll again" do
    user = FactoryGirl.create(:user)
    challenge = FactoryGirl.create(:challenge)
    # Enroll
    challenge.enroll(user).should be_an_instance_of(Enrollment)

    # Unenroll
    challenge.unenroll(user).should be_true
    enrollment = challenge.enrollments.first
    enrollment.unenrolled_at.should_not be_nil

    # Enroll
    challenge.enroll(user).should be_true
    enrollment.reload
    enrollment.unenrolled_at.should be_nil

  end
end
