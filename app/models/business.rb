class Business < ApplicationRecord
  include Avatarable
  include Businesses::HasOnlineProfiles
  include Businesses::Notifications
  include PersonName

  enum :developer_notifications, %i[no daily weekly], default: :no, suffix: true

  belongs_to :user
  has_one :referring_user, through: :user
  has_many :conversations, -> { visible }
  has_many :favorite_developers

  has_noticed_notifications

  validates :contact_name, presence: true
  validates :company, presence: true
  validates :bio, presence: true
  validates :developer_notifications, inclusion: {in: developer_notifications.keys}

  alias_attribute :name, :contact_name

  delegate :email, to: :referring_user, prefix: true, allow_nil: true

  def visible?
    !invisible?
  end

  def toggle_favorites(developer_id)
    if self.favorite_developers.where(:developer_id => developer_id).count == 0
      FavoriteDeveloper.create(:business_id => self.id , :developer_id => developer_id)
    else
      FavoriteDeveloper.where(:business_id => self.id , :developer_id => developer_id).delete_all
    end
  end
end
