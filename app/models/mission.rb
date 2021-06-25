# frozen_string_literal: true

class Mission < ApplicationRecord
  belongs_to :user
  has_many :missions_tags, dependent: :destroy
  has_many :tags, through: :missions_tags

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, :status, :priority, :user_id, presence: true
  validate :validate_end_time_after_start_time

  enum status: { pending: 0, processing: 1, completed: 2 }
  enum priority: { low: 0, mid: 1, high: 2 }

  # kaminali default mission in per page
  paginates_per 15

  # setter
  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.find_or_create_by(label: name.strip)
    end
  end

  # getter
  def all_tags
    tags.map(&:label).join(',')
  end

  def self.ransackable_attributes(*)
    super << 'title_or_tags_label_cont_any'
  end

  private

  def validate_end_time_after_start_time
    return if started_at.blank? || ended_at.blank?
    return if started_at < ended_at

    error_message = I18n.t('activerecord.errors.models.mission.attributes.ended_at.before_start_time')
    errors.add(:ended_at, error_message)
  end
end
