class UsersController < ApplicationController
  before_action :find_user, except: %i(index new create)
  before_action :logged_in_user, except: %i(new show create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.all.page(params[:page]).per Settings.paginate
  end

  def new
    @user = User.new
  end

  def show
    @microposts = @user.microposts.create_desc.page(params[:page])
                       .per Settings.paginate
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t "please_check"
      redirect_to root_url
    else
      flash.now[:danger] = t "error"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_deleted"
    else
      flash[:danger] = t "delete_failed"
    end
    redirect_to users_url
  end

  def following
    @title = "Following"
    @users = @user.following.all.page(params[:page])
    render "show_follow"
  end

  def followers
    @title = "Followers"
    @users = @user.followers.all.page(params[:page])
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "please_login"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless current_user?(@user)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:warning] = t "not_found"
    redirect_to root_path
  end
end
