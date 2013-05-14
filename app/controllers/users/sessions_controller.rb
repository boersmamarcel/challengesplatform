class Users::SessionsController < Devise::SessionsController

  skip_filter :authenticate_user!
  skip_filter :require_admin
  skip_filter :require_supervisor

end