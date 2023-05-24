class UsersController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  #GET /users and 
  def show
      user = User.find(params[:id])
      render json: user, include: :items, status: :ok
  end

  private

  def render_not_found_response(invalid)
    render json: {errors: invalid}, status: :not_found
  end

end
