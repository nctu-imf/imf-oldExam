class Semester < ActiveRecord::Base
  has_many :courses
end
