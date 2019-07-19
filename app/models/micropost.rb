class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  scope :create_desc, ->{order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.maximum_length_content}
  validate :picture_size

  private

  def picture_size
    return unless picture.size > Settings.picture_size.megabytes
    errors.add(:picture, I18n.t("error_picture"))
  end
end
