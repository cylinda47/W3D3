class ShortenedUrl < ApplicationRecord

  validates :submitter_id, :long_url, presence: true
  validates :short_url, presence: true, uniqueness: true

  def self.random_code
    url = SecureRandom.urlsafe_base64
    return url unless ShortenedUrl.exists?(short_url: url)
    self.random_code
  end

  def self.create_short_url_for_user!(user, long_url)
    new_url = self.new(
      submitter_id: user.id,
      long_url: long_url,
      short_url: ShortenedUrl.random_code
    )
    new_url.save
    new_url
  end

  belongs_to :submitter,
    class_name: :User,
    primary_key: :id,
    foreign_key: :submitter_id

  has_many :visits,
    class_name: :Visit,
    primary_key: :id,
    foreign_key: :short_url_id

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits
      .select('submitter_id')
      .where('created_at > ?', 10.minutes.ago)
      .distinct
      .count
  end

end
