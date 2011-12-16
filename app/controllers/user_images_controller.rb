class UserImagesController < ApplicationController

  # GET /user_images/1
  # GET /user_images/1.json
  def show
    @user_image = UserImage.find(params[:id])

    respond_to do |format|
      format.html # detail.html.erb
      format.json { render json: @user_image }
    end
  end

end
