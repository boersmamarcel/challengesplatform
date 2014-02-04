require_relative '../spec_helper'

describe User do
  it "should describe the right role" do
    u_admin = FactoryGirl.build(:user, :role => 2)
    u_super = FactoryGirl.build(:user, :role => 1)
    u_participant = FactoryGirl.build(:user, :role => 0)

    u_admin.is_supervisor?.should       be_true
    u_admin.is_admin?.should            be_true
    u_super.is_supervisor?.should       be_true
    u_super.is_admin?.should            be_false
    u_participant.is_supervisor?.should be_false
    u_participant.is_admin?.should      be_false
  end

  it "should be able to determine if a user can send a message to followers" do
    kees = FactoryGirl.create(:user, :email => "keesstudent@student.utwente.nl")
    daan = FactoryGirl.create(:user, :email => "daanstudent@student.utwente.nl")
    lina = FactoryGirl.create(:user, :email => "linastudent@student.utwente.nl")

    kees.followers << [lina, daan]
    lina.followers << [kees, daan]

    kees.can_send_message_to_user?(daan).should be_true
    lina.can_send_message_to_user?(daan).should be_true
    # daan.can_send_message_to_user?(kees).should be_false
    daan.can_send_message_to_user?(kees).should be_true
  end

  it "should be able to determine if a user can send a message to a user in same challenge" do
    kees = FactoryGirl.create(:user, :email => "keesstudent@student.utwente.nl")
    daan = FactoryGirl.create(:user, :email => "daanstudent@student.utwente.nl")
    lina = FactoryGirl.create(:user, :email => "linastudent@student.utwente.nl")

    koek_challenge = FactoryGirl.create(:challenge)
    data_challenge = FactoryGirl.create(:challenge)

    kees.participating_challenges << koek_challenge
    lina.participating_challenges << [koek_challenge, data_challenge]
    daan.participating_challenges << data_challenge

    # kees.can_send_message_to_user?(daan).should be_false
    kees.can_send_message_to_user?(daan).should be_true
    kees.can_send_message_to_user?(lina).should be_true
    lina.can_send_message_to_user?(daan).should be_true
    lina.can_send_message_to_user?(kees).should be_true
    daan.can_send_message_to_user?(lina).should be_true
  end

  it "should be able to determine if a user can send a message to a challenge" do
    kees = FactoryGirl.create(:user, :email => "keesstudent@student.utwente.nl", :role => 1)
    daan = FactoryGirl.create(:user, :email => "daanstudent@student.utwente.nl", :role => 1)

    koek_challenge = FactoryGirl.create(:challenge, :supervisor => kees)
    data_challenge = FactoryGirl.create(:challenge, :supervisor => daan)

    kees.can_send_message_to_participants?(koek_challenge).should be_true
    daan.can_send_message_to_participants?(data_challenge).should be_true
    daan.can_send_message_to_participants?(koek_challenge).should be_false
  end

  it "should be active for authentication" do
    kees = FactoryGirl.create(:user, :email => "keesstudent@student.utwente.nl", :role => 1)
    daan = FactoryGirl.create(:user, :email => "daanstudent@student.utwente.nl", :role => 1)
    daan.active = false;

    kees.active_for_authentication?.should be_true
    daan.active_for_authentication?.should be_false
  end

  it "should know how to generate reset password codes" do
    not_activated = FactoryGirl.create(:user, :email => "not_act@student.utwente.nl", :active => false)

    not_activated.reset_password_token.should be_nil
    not_activated.ensure_reset_password_token!
    not_activated.reset_password_token.should_not be_nil
    not_activated.reset_password_sent_at.today?.should be_true
  end
end
