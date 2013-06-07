module Supervisor::ReviewHelper

	def submit_resubmit_name(challenge)
		if challenge.draft?
			return "Submit for Review"
		elsif challenge.declined?
			return "Resubmit for Review"
		end
	end

end
