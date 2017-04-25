class User < ApplicationRecord
  acts_as_voter
  validates :name, presence: true, length: { minimum: 4, maximum: 16 }

  has_many :posts
  has_many :comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: '180x180#' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
