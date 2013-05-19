class Users::PasswordsController < Devise::PasswordsController

  skip_filter :authenticate_user!, :require_admin, :require_supervisor

end