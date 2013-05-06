module ChallengesHelper
  
  def enrolled?
    enrolled = false
    return false if current_user.nil?
    current_user.enrollments.each do |e|
      if e.challenge.id == @challenge.id
        enrolled = true
      end
    
    end
    enrolled
  end
  
end
