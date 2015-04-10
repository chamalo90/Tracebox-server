#require 'ipaddress'

class CreatePcapUploads < ActiveRecord::Migration
  def change
    create_table :pcap_uploads do |t|
      t.integer :script
      t.string :source

      t.timestamps null: false
    end
  end
end
