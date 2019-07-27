class CommentsController < ApplicationController
  before_action :load_micropost
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_comment, only: :destroy

  def create
    @comment = @micropost.comments.build comment_params
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html{redirect_to root_path}
        format.js
      end
    else
      flash[:danger] =  "comment fail"
      render root_path
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html{redirect_to request.referrer || root_url}
        format.js
      end
    else
      flash[:danger] = "delete fail"
      render root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def load_micropost
    @micropost = Micropost.find_by id: params[:micropost_id]
    return if @micropost
    flash[:danger] = "micropost not found"
    redirect_to root_url
  end

  def correct_comment
    @comment = current_user.comments.find_by id: params[:id]
    return if @comment
    flash[:danger] = "comment not found"
    redirect_to root_url
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "please_login"
    redirect_to login_url
  end
end
