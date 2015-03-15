class ProfilesController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_attributes)
      redirect_to @user, notice: "Your profile has been updated"
    else
      render :edit
    end
  end

  private

  def user_attributes
    params.require(:user).permit(User.editable_attributes.map(&:to_sym))
  end
end
