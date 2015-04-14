class PcapUploadsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_pcap_upload, only: [:show, :edit, :update, :destroy]

  # GET /pcap_uploads
  # GET /pcap_uploads.json
  def index
    @pcap_uploads = PcapUpload.all
  end

  # GET /pcap_uploads/1
  # GET /pcap_uploads/1.json
  def show
  end

  # GET /pcap_uploads/new
  def new
    @pcap_upload = PcapUpload.new
  end

  # GET /pcap_uploads/1/edit
  def edit
  end

#POST /pcap_uploads/curl
def curl
    #logger.debug "%%%%%%%%% CURL %%%%%%%%%%%%%%%"
    #logger.debug "#{params[:script]}"
    #logger.debug "#{params[:source]}"

    filename||= "#{SecureRandom.urlsafe_base64}.pcap"
    
    tempfile = Tempfile.new("upload")
    tempfile.binmode
    tempfile << request.body.read
    tempfile.rewind

    data = tempfile.read.split("&").last.bytes
    tempfile.close
    tempfile.unlink

    File.open(File.join(Rails.root, "/public/uploads/" << filename), 'w') { |f| 
      f.write(data) 
    }
    

    @pcap_upload = PcapUpload.new
    @pcap_upload.source = params[:source]
    @pcap_upload.script = params[:script]
    @pcap_upload.uploader = File.new(File.join(Rails.root, "/public/uploads/pcap_upload/uploader/" << filename))


    respond_to do |format|
      if @pcap_upload.save
        format.json { head :ok }
      else
        format.json { render :json => @postcard.errors, :status => :unprocessable_entity }
      end
      tempfile.close
      tempfile.unlink
    end
  end



  # POST /pcap_uploadsx
  # POST /pcap_uploads.json
  def create
    @pcap_upload = PcapUpload.new(pcap_upload_params)

    @pcap_upload.uploader.store!(File.open(@pcap_upload.uploader.current_path))
    respond_to do |format|
      if @pcap_upload.save!
        format.html { redirect_to @pcap_upload, notice: 'Pcap upload was successfully created.' }
        format.json { render :show, status: :created, location: @pcap_upload }
      else
        format.html { render :new }
        format.json { render json: @pcap_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pcap_uploads/1
  # PATCH/PUT /pcap_uploads/1.json
  def update
    respond_to do |format|
      if @pcap_upload.update(pcap_upload_params)
        format.html { redirect_to @pcap_upload, notice: 'Pcap upload was successfully updated.' }
        format.json { render :show, status: :ok, location: @pcap_upload }
      else
        format.html { render :edit }
        format.json { render json: @pcap_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pcap_uploads/1
  # DELETE /pcap_uploads/1.json
  def destroy
    @pcap_upload.destroy
    respond_to do |format|
      format.html { redirect_to pcap_uploads_url, notice: 'Pcap upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pcap_upload
      @pcap_upload = PcapUpload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pcap_upload_params
      params.require(:pcap_upload).permit(:script, :source, :uploader)
    end
end
