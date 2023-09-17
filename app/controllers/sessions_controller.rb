class SessionsController < AuthenticatedController
  skip_before_action :authenticate_user
  before_action :deny_access, only: %i[new create]
  layout 'unauthenticated', only: %i[new create]

  def new
    @session_form = SessionForm.new
  end

  def create
    @session_form = SessionForm.new session_params

    if @session_form.save
      session[:user_id] = User.find_by(email: session_params[:email]).id
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def session_params
    params.require(:session_form).permit(:email, :password)
  end
end
