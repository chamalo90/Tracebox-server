Rails.application.routes.draw do
  resources :pcap_uploads
  post "/curl" => "pcap_uploads#curl"

end
