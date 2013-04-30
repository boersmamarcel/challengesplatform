Devise.setup do |config|

  require "omniauth-google-oauth2"

    config.omniauth :google_oauth2, "407351876767-ch2ptoffv2di9qrujohdf7vahe0jt03r.apps.googleusercontent.com", "Dw5R_cJBcF4_3Wjn2hMIH8M_", { :access_type => "offline", :approval_prompt => "" } 

    Devise.mailchimp_api_key = 'ec7f0e9116f810d442fd8821f30cac9d-us6'
    Devise.mailing_list_name = 'Challenges'
end
