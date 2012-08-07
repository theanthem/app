class Home < ActiveRecord::Base
  
  validates_presence_of :home_title
  validates_length_of :home_title, :maximum => 100
  
  scope :visible, where(:visibility => true)
  scope :hidden, where(:visibility => false)
  scope :sorted, order('homes.position ASC')
  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}
  
end
