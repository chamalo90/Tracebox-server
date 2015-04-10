require 'test_helper'

class PcapUploadsControllerTest < ActionController::TestCase
  setup do
    @pcap_upload = pcap_uploads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pcap_uploads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pcap_upload" do
    assert_difference('PcapUpload.count') do
      post :create, pcap_upload: { script: @pcap_upload.script, source: @pcap_upload.source }
    end

    assert_redirected_to pcap_upload_path(assigns(:pcap_upload))
  end

  test "should show pcap_upload" do
    get :show, id: @pcap_upload
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pcap_upload
    assert_response :success
  end

  test "should update pcap_upload" do
    patch :update, id: @pcap_upload, pcap_upload: { script: @pcap_upload.script, source: @pcap_upload.source }
    assert_redirected_to pcap_upload_path(assigns(:pcap_upload))
  end

  test "should destroy pcap_upload" do
    assert_difference('PcapUpload.count', -1) do
      delete :destroy, id: @pcap_upload
    end

    assert_redirected_to pcap_uploads_path
  end
end
