Rails.application.routes.draw do
  resources :pcap_uploads
  post "/pcap_uploads/curl" => "pcap_uploads#curl"

end
