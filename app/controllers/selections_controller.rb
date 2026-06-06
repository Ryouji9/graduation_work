class SelectionsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @era = params[:era]
    @worries = params[:worries] || []
    @feeling = params[:feeling]

    anthropic_service = AnthropicService.new
    @episode = anthropic_service.generate_episode(@era, @worries, @feeling)

    render :result
  end
end
