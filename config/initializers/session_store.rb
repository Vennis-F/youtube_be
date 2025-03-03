Rails.application.config.session_store :cookie_store, key: "remitube_auth_session", 
                                         domain: :all, 
                                         same_site: :lax
