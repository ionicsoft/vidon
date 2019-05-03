class VideoCommentsController < ApplicationController
  before_action :set_video_comment, only: [:show, :edit, :update, :destroy]
  #Authorization
  before_action :logged_in_any, only: [:show]
  before_action :logged_in_customer, only: [:create, :edit, :update, :destroy]

  # POST /video_comments
  # POST /video_comments.json
  def create
    @video_comment = VideoComment.new(video_comment_params)
    session[:return_to] ||= request.referer

    if @video_comment.save
      redirect_to session.delete(:return_to), notice: 'Comment posted.'
    else
      render :new
    end
  end

  # PATCH/PUT /video_comments/1
  # PATCH/PUT /video_comments/1.json
  def update
    if @video_comment.update(video_comment_params)
      redirect_to @video_comment, notice: 'Video comment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /video_comments/1
  # DELETE /video_comments/1.json
  def destroy
    if @video_comment.customer.person == current_person
      session[:return_to] ||= request.referer
      @video_comment.destroy
      redirect_to session.delete(:return_to), notice: 'Comment deleted.'
    else
      redirect_to root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video_comment
      @video_comment = VideoComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_comment_params
      params.require(:video_comment).permit(:creation, :video_id, :customer_id, :comment)
    end
end
