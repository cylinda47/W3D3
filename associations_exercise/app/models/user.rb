class User < ApplicationRecord
  validates :name, presence: true

  has_many :enrollments,
    class_name: :Enrollment,
    primary_key: :id,
    foreign_key: :student_id

  has_many :enrolled_courses,
    through: :enrollments,
    source: :course
end
