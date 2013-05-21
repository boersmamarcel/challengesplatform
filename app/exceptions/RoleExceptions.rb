module RoleException
	class SupervisorLevelRequired < RuntimeError
		
	end

	class AdminLevelRequired < RuntimeError

	end
end