require 'oa-oauth'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '173041622753730', '627e9cb9cf7a43d30f892b3e35f63d35',
           {:scope => 'publish_stream'}
  provider :twitter, 'tZ75FWbEdbPeO5y3D75whQ', 'NznoUTLWTsbGW0G4sfu4B3UqRWNz97E70pPjCBe4U'
end
