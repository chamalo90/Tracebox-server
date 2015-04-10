json.array!(@pcap_uploads) do |pcap_upload|
  json.extract! pcap_upload, :id, :script, :source
  json.url pcap_upload_url(pcap_upload, format: :json)
end
