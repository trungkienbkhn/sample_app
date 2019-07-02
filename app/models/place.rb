class Place < ApplicationRecord
  enum status: [:hotel, :restaurant]
  belongs_to :user
  mount_uploader :photo, PhotoUploader

  validates :name, presence: true, length: {maximum: 255}
  validates :description, presence: true, length: {maximum: 65536}
  validates :address, presence: true, length: {maximum: 255}
  validates :vote, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :cost, presence: true, length: {maximum: 65536}
end
