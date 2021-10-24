class UsersController < ApplicationController
  def edit
  end


  def update
    if current_user.update(user_params) # 1
      redirect_to root_path
    else
      render :edit
    end 
  end

  private

  def user_params
    params.require(:user).permit(:name, :email) # 1
  end
end
