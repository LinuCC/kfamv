class Kf::UsersController < ApplicationController
  def show
    @user = Kf::User.find(params[:id])
  end
end
