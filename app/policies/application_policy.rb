class ApplicationPolicy
  attr_reader :user

  def initialize(user, record)
    @user = user
    @record = record
    # @sell = sell
  end
end
