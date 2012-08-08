class News < ActiveRecord::Base
  
  has_and_belongs_to_many :editors, :class_name => "User"
  acts_as_list
  is_impressionable
  
  has_attached_file :news_thumb, :styles  => { 
    :small => "260x260>", :medium => "500x500>", :large => "900x900>", :thumbnail => "126x78>"},
    :storage => :s3,
         :s3_credentials => {
           :bucket            => ENV['S3_BUCKET_NAME'],
           :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
           :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
         },
    :path => "/images/:class/:id/:attachment_:style.:extension",
    :default_url  => "/images/:class/:attachment/default.jpg"
    
  has_attached_file :news_display, :styles  => { 
    :small => "260x260>", :medium => "500x500>", :large => "900x900>", :thumbnail => "126x78>"},
    :storage => :s3,
         :s3_credentials => {
           :bucket            => ENV['S3_BUCKET_NAME'],
           :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
           :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
         },
    :path => "/images/:class/:id/:attachment_:style.:extension",
    :default_url  => "/images/:class/:id/:attachment/default.jpg"
    
  before_save { |news| news.permalink = news.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if news.permalink.blank?}
  before_save { |news| news.permalink = news.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if news.permalink }
  before_save :perform_remove_thumb, :perform_remove_display 
  attr_accessor :remove_thumb, :remove_display
    
  STATUS = ['Published', 'Draft', 'Pending']
  
  validates_presence_of :title
  validates_length_of :title, :maximum => 255
  # use presence with length to disallow spaces
  validates_uniqueness_of :permalink
  validates_presence_of :description
  validates_inclusion_of :status, :in => STATUS, 
    :message => "must be one of: #{STATUS.join(', ')}"
  
  scope :published, where(:status => "Published")
  scope :draft, where(:status => "Draft")
  scope :pending, where(:status => "Pending")
  scope :sorted, order('news.position ASC')
  scope :featured, where(:featured_news => true)
  
  def self.search(search, page)
    paginate :per_page => 10, :page => page,
               :conditions => ['title like ?', "%#{search}%"]
  end
  
  def perform_remove_thumb
    self.news_thumb = nil if self.remove_thumb=="1" && ! 
    self.news_thumb.dirty? 
    true 
  end
  
  def perform_remove_display
    self.news_display = nil if self.remove_display=="1" && ! 
    self.news_display.dirty? 
    true 
  end
  
end
