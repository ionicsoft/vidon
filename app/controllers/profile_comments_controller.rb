class ProfileCommentsController < ApplicationController
  before_action :set_profile_comment, only: [:show, :edit, :update, :destroy]
  # Authorization
  before_action :logged_in_customer

  # POST /profile_comments
  # POST /profile_comments.json
  def create
    @profile_comment = ProfileComment.new(profile_comment_params)
    session[:return_to] ||= request.referer
    
    if @profile_comment.save
      redirect_to session.delete(:return_to), notice: 'Profile comment was successfully created.'
    else
      redirect_to session.delete(:return_to), notice: 'Failed to create comment.'
    end
  end

  # PATCH/PUT /profile_comments/1
  # PATCH/PUT /profile_comments/1.json
  def update
    session[:return_to] ||= request.referer
    if @profile_comment.update(profile_comment_params)
      redirect_to session.delete(:return_to), notice: 'Profile comment was successfully updated.'
    else
      redirect_to session.delete(:return_to), notice: 'Failed to update comment.'
    end
  end

  # DELETE /profile_comments/1
  # DELETE /profile_comments/1.json
  def destroy
    @profile_comment.destroy
    redirect_to profile_comments_url, notice: 'Profile comment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_comment
      @profile_comment = ProfileComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_comment_params
      params.require(:profile_comment).permit(:creation, :customer_id, :commentor_id, :comment)
    end
end
