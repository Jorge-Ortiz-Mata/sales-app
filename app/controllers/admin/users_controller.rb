module Admin
  class UsersController < AuthenticatedController
    before_action :authorize_user

    def index
      @users = User.joins(:profile).order(:first_name)
    end

    def new
      @user = AdminUser.new
    end

    def create
      @user = AdminUser.new user_params

      respond_to do |format|
        if @user.save
          format.html { redirect_to admin_users_path, notice: 'El usuario ha sido creado exitosamente' }
        else
          format.turbo_stream { render turbo_stream: turbo_stream.replace('admin_user_form', partial: 'admin/users/form', locals: { user: @user }) }
        end
      end
    end

    def destroy
      debugger
    end

    private

    def set_user
      @user = User.find_by(token_id: params[:token_id])
    end

    def authorize_user
      authorize current_user
    end

    def user_params
      params.require(:admin_user).permit(:email, :password, :first_name, :last_name, :phone_number, :role)
    end
  end
end
