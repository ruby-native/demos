class AccountsController < ApplicationController
  def show
    render inertia: "Accounts/Show", props: {
      user: current_user.slice(:id, :name, :email, :favorite_store, :reward_points)
    }
  end

  def edit
    render inertia: "Accounts/Edit", props: {
      user: current_user.slice(:id, :name, :email, :favorite_store),
      errors: current_user.errors.full_messages
    }
  end

  def update
    if current_user.update(account_params)
      redirect_to account_path, notice: "Account updated."
    else
      render inertia: "Accounts/Edit", props: {
        user: current_user.slice(:id, :name, :email, :favorite_store),
        errors: current_user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:user).permit(:name, :email, :favorite_store)
  end
end
