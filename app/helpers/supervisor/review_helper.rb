module Supervisor::ReviewHelper

	def submit_resubmit_name(challenge)
		if challenge.declined?
			return "Resubmit for Review"
		elsif challenge.id.nil? || challenge.draft?
			return "Submit for Review"
		end
	end

end
