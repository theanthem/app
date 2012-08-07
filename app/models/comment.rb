class Comment < ActiveRecord::Base
  
  belongs_to :post, :counter_cache => true
  
  def self.search(search, page)
    paginate :per_page => 10, :page => page,
               :conditions => ['author like ?', "%#{search}%"], :order => 'created_at'
  end
  
  scope :sorted, order('comments.position ASC')
  
  
end
