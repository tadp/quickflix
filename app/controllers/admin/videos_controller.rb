class Admin::VideosController < AdminsController
  def new
    @video = Video.new
  end

  def create
    category_ids = params[:video][:categories]
    category_ids = category_ids[1..-1]
    @video = Video.new(video_params)
    @video.categories = Category.find(category_ids)
    if @video.save
      flash[:success] = "You successfully added the video '#{@video.title}."
      redirect_to new_admin_video_path
    else
      flash[:error] = "You cannot add this video. Please check the errors"
      render :new
    end
  end
  

  private

  def video_params
    params.require(:video).permit(:title, :description, :large_cover, :small_cover, :video_url)
  end

end