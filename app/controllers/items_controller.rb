class ItemsController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  #GET /users/:user_id/items/:id
  def show
    if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items.find(params[:id])
      render json: item, status: :ok
    else
      item = Item.find(params[:id])
      render json: item, include: :user
    end
  end

  #GET /users/:user_id/items
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      return render json: user.items, status: :ok
    else
      items = Item.all
      render json: items, include: :user
    end
  end

  #POST /users/:user_id/items/:id
  def create
    if params[:user_id]
      user = User.find(params[:user_id])
      new_item = user.items.create(item_params)
      return render json: new_item, status: :created
    else
      item = Item.create(item_params)
      render json: item, status: :created
    end
  end

  private

  def item_params
    params.permit(:name, :description, :price, :user_id, :item)
  end

  def render_not_found_response(invalid)
    render json: {errors: invalid}, status: :not_found
  end
end
