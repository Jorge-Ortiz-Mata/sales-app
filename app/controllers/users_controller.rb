class UsersController < AuthenticatedController
  skip_before_action :authenticate_user, only: %i[new create confirm_account]
  before_action :deny_access, only: %i[new create]
  before_action :set_user, only: %i[edit update show destroy confirm_account]
  before_action :authorize_user, only: %i[edit update destroy]
  layout 'unauthenticated', only: %i[new create]

  def new
    @user = User.new
  end

  def edit; end

  def show; end

  def create
    @user = User.new user_params

    if @user.save
      UserMailer.with(user: @user).send_email_confirmation.deliver_later
      redirect_to login_path, notice: 'Verifica tu bandeja de entrada y confirma tu correo electónico'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.authenticate(params[:user][:old_password])
      if @user.update user_params
        redirect_to user_path(@user.token_id), notice: 'Tu cuenta ha sido actualizada exitosamente'
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to edit_user_path(@user.token_id), status: :unprocessable_entity, notice: 'La contraseña anterior es incorrecta'
    end
  end

  def destroy
    session[:user_id] = nil
    @user.destroy

    redirect_to login_path, notice: 'Tu cuenta ha sido desactivada exitosamente'
  end

  def confirm_account
    if @user.present?
      if @user.confirmed?
        flash[:notice] = 'Tu cuenta ya ha sido confirmada anteriormente'
      else
        @user.update!(active: true)
        flash[:notice] = 'Tu cuenta ha sido confirmada exitosamente'
      end
    else
      flash[:notice] = 'No se encontró ningún usuario con este link de confirmación'
    end
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find_by(token_id: params[:token_id])
    return @user if @user.present?

    redirect_to root_path, notice: 'No existe ningún usuario con este registro'
  end

  def authorize_user
    return if current_user.eql? @user

    redirect_to root_path, notice: 'No estas autorizado para realizar este procedimiento'
  end
end
