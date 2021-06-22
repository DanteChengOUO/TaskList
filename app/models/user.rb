# frozen_string_literal: true

class User < ApplicationRecord
  before_update :abort_update_on_last_admin
  before_destroy :abort_if_last_admin
  has_many :missions, dependent: :destroy
  has_secure_password

  enum role: { user: 0, admin: 1 }

  # kaminali default mission in per page
  paginates_per 15

  validates :name, :role, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_confirmation, presence: true, on: :create

  private

  def abort_if_last_admin
    return unless admin?
    return unless User.where(role: :admin).size == 1

    error_message = I18n.t('activerecord.errors.models.user.attributes.admin_less_than_one')
    errors.add(:role, error_message)
    throw :abort
  end

  def abort_update_on_last_admin
    return unless role_change_to_user?(self)
    return unless User.where(role: :admin).size == 1

    error_message = I18n.t('activerecord.errors.models.user.attributes.admin_less_than_one')
    errors.add(:role, error_message)
    throw :abort
  end

  def role_change_to_user?(record)
    return true if record.role_changed? && record.user?

    false
  end
end
