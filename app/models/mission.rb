# frozen_string_literal: true

class Mission < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, :status, :priority, presence: true
  validate :validate_end_time_after_start_time

  enum status: { pending: 0, processing: 1, completed: 2 }
  enum priority: { low: 0, mid: 1, high: 2 }

  # kaminali default mission in per page
  paginates_per 15

  private

  def validate_end_time_after_start_time
    return if started_at.blank? || ended_at.blank?
    return if started_at < ended_at

    error_message = I18n.t('activerecord.errors.models.mission.attributes.ended_at.before_start_time')
    errors.add(:ended_at, error_message)
  end
end
