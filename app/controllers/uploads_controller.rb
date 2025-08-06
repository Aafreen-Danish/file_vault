class UploadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_upload, only: [:destroy, :show]

  def index
    @uploads = current_user&.uploads
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = current_user.uploads.build(upload_params)
    if @upload.save
      # optional: handle compression in background
      redirect_to uploads_path, notice: "File uploaded successfully."
    else
      render :new
    end
  end

  def destroy
    @upload.destroy
    redirect_to uploads_path, notice: "File deleted."
  end

  def shared
    @upload = Upload.find_by(short_url: params[:short_url])
    if @upload&.file&.attached?
      redirect_to rails_blob_url(@upload.file, disposition: "inline")
    else
      render plain: "File not found", status: :not_found
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:title, :description, :file)
  end

  def set_upload
    @upload = current_user.uploads.find(params[:id])
  end
end
