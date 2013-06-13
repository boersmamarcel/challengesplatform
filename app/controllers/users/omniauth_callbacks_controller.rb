class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  skip_filter :authenticate_user!, :require_admin, :require_supervisor

  def google_oauth2

      if request.env["omniauth.auth"].info['email'] =~ /(.+)utwente.nl/
  	    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
  	    
        if @user.persisted?
  	      sign_in_and_redirect @user, :event => :authentication
  	    else
  	      session["devise.google_data"] = request.env["omniauth.auth"]
  	      redirect_to new_user_registration_url
  	    end
  	  else
  	      flash[:error] = "Only people associated with the University of Twente can sign up. Please sign up with your utwente.nl email address."
  	      redirect_to new_user_session_path
  	  end
  	end

end
