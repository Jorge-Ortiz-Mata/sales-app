class UpdateAccount
  include ActiveModel::Model

  attr_accessor :id, :email, :password, :password_confirmation, :old_password

  validates :email, :old_password, presence: true
  validates :password, presence: true, if: :password_confirmation_is_present?
  validates :password_confirmation, presence: true, if: :password_is_present?

  validates :password, length: { minimum: 8 }, if: :password_is_present?
  validates :password_confirmation, length: { minimum: 8 }, if: :password_confirmation_is_present?
  validate :same_passwords, if: :both_passwords_are_present?

  def initialize(id, email, password, password_confirmation, old_password)
    self.id = id
    self.email = email
    self.password = password
    self.password_confirmation = password_confirmation
    self.old_password = old_password
  end

  def save
    return false if invalid?

    User.find(id).update(email: email, password: password, password_confirmation: password_confirmation)

    true
  end

  private

  def same_passwords
    errors.add(:password_confirmation, :passwords_do_not_match) unless password.eql? password_confirmation
  end

  def both_passwords_are_present?
    return true if password.present? && password_confirmation.present?

    false
  end

  def password_is_present?
    return true if password.present?

    false
  end

  def password_confirmation_is_present?
    return true if password_confirmation.present?

    false
  end
end
