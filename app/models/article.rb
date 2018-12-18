class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true

  validates :title ,length: {minimum: 2,maximum: 100}
  validates :description,length: {minimum:5,maximum: 1000}
end