class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.all
    if params[:restaurant_id] != nil
      @restaurant = Restaurant.find_by_id(params[:restaurant_id])
      @menus = @restaurant.menus 
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)

    respond_to do |format|
      if @menu.save
        @restaurant = Restaurant.find_by_id(menu_params[:restaurant_id])
        @restaurant.save    # Update updated_time of restaurant

        format.html { redirect_to controller: 'menus', action: 'index', restaurant_id: menu_params[:restaurant_id], notice: 'Menu was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @menu }
      else
        format.html { render action: 'new' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu.update(menu_params)
        @restaurant = Restaurant.find_by_id(menu_params[:restaurant_id])
        @restaurant.save     # Update updated_time of restaurant

        format.html { redirect_to controller: 'menus', action: 'index', restaurant_id: @menu.restaurant_id, notice: 'Menu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    restaurant_id = @menu.restaurant_id
    @menu.destroy

    @restaurant = Restaurant.find_by_id(restaurant_id)
    @restaurant.save     # Update updated_time of restaurant

    respond_to do |format|
      format.html { redirect_to controller: 'menus', action: 'index', restaurant_id: restaurant_id, notice: 'Menu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:section, :name, :price, :restaurant_id)
    end
end
