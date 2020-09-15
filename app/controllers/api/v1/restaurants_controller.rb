class Api::V1::RestaurantsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_restaurant, except: [:index, :create]

  def index
    # @restaurants = Restaurant.all
    @restaurants = policy_scope(Restaurant)
  end

  def show; end

  def update
    if @restaurant.update(restaurant_params)
      render :show, status: :ok
    else
      render_error
    end
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user

    authorize @restaurant
    if @restaurant.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @restaurant.destroy
    render_success
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address)
  end

  def render_error
    render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
  end

  def render_success
    render json: { message: "YOU DID IT, YOU DELETED A RESTAURANT!"}, status: :ok
  end
end



