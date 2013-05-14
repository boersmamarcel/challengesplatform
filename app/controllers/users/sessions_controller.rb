class SessionsController < Devise::SessionsController

  skip_filter :authenticate_user!, :require_admin, :require_supervisor

end