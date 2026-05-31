class SelectionsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @era = params[:era]
    @worries = params[:worries]
    @feeling = params[:feeling]
    redirect_to new_selection_path
  end
end
