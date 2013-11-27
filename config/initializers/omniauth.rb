Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'db22cf2b33c4a805a0cc', '4ef31c1061b592ad90b9f8c3832fa9f334124186' #, scope: "user:email,user:follow"
end