class AddUploaderToPcapUpload < ActiveRecord::Migration
  def change
    add_column :pcap_uploads, :uploader, :string
  end
end
