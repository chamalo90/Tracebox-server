require 'carrierwave/orm/activerecord'

class PcapUpload < ActiveRecord::Base
	mount_uploader :uploader, PcapUploader
end
