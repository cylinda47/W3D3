class Enrollment < ApplicationRecord
  validates :student_id, presence: true, uniqueness: true

  belongs_to :user,
    class_name: :User,
    primary_key: :id,
    foreign_key: :student_id

  belongs_to :course,
    class_name: :Course,
    primary_key: :id,
    foreign_key: :course_id
end
