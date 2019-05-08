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

    respond_to do |format|
      if @video_comment.save
        format.html { redirect_to session.delete(:return_to), notice: 'Comment posted.' }
        format.json { render :show, status: :created, location: @video_comment }
      else
        format.html { render :new }
        format.json { render json: @video_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /video_comments/1
  # PATCH/PUT /video_comments/1.json
  def update
    respond_to do |format|
      if @video_comment.update(video_comment_params)
        format.html { redirect_to @video_comment, notice: 'Video comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @video_comment }
      else
        format.html { render :edit }
        format.json { render json: @video_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /video_comments/1
  # DELETE /video_comments/1.json
  def destroy
    if @video_comment.customer.person == current_person
      session[:return_to] ||= request.referer
      @video_comment.destroy
      respond_to do |format|
        format.html { redirect_to session.delete(:return_to), notice: 'Comment deleted.' }
        format.json { head :no_content }
      end
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
