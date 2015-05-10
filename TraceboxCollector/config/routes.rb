Rails.application.routes.draw do
  post "/curl" => "pcap_uploads#curl"
  get '*path' => redirect('/')

end
