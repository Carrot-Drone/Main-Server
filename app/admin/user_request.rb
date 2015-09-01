ActiveAdmin.register UserRequest do
  index do
    column :email
    column :details
  end

  controller do
    before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user_request, only: [:show, :edit, :create, :update, :destroy]
    private
    def set_user_request
      @user_request = UserRequest.find(params[:id])
    end

    def authenticate_user_request
      if current_admin == nil or not current_admin.is_super_admin
        redirect_to :root
      end
    end
  end

  config.filters = false
end
