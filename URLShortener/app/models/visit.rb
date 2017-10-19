class Visit < ApplicationRecord

  validates :submitter_id, :short_url_id, presence: true

  def self.record_visit!(user, shortened_url)
    visit = self.new(
      submitter_id: user.id,
      short_url_id: shortened_url.id
    )
    visit.save
    visit
  end

  belongs_to :visitor,
    class_name: :User,
    primary_key: :id,
    foreign_key: :submitter_id

  belongs_to :url,
    class_name: :ShortenedUrl,
    primary_key: :id,
    foreign_key: :short_url_id

end
