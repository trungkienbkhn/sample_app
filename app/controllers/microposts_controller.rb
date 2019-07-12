class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :load_micropost, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)

    if @micropost.save
      flash[:success] = t "micropost_create"
      redirect_to root_url
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "micropost_delete"
    else
      flash[:danger] = t "delete_failed"
    end
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "please_login"
    redirect_to login_url
  end

  def load_micropost
    @micropost = current_user.microposts.find_by id: params[:id]

    return if @micropost
    flash[:danger] = t "not_found_micropost"
    redirect_to root_url
  end
end
