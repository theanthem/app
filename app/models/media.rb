class Media < ActiveRecord::Base
  
  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id'
  # Alias for <tt>acts_as_taggable_on :tags</tt>:
  acts_as_taggable
  acts_as_taggable_on
  is_impressionable
  
  has_attached_file :media_thumb, :styles  => { 
    :small => "260x260>", :medium => "500x500>", :large => "900x900>", :thumbnail => "126x78>"},
    :storage => :s3,
         :s3_credentials => {
           :bucket            => ENV['S3_BUCKET_NAME'],
           :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
           :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
         },
    :path => "/images/:class/:id/:attachment_:style.:extension",
    :default_url  => "/images/:class/:attachment/default.jpg"
    
  has_attached_file :media_display, :styles  => { 
    :small => "260x260>", :medium => "500x500>", :large => "900x900>", :thumbnail => "126x78>"},
    :storage => :s3,
         :s3_credentials => {
           :bucket            => ENV['S3_BUCKET_NAME'],
           :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
           :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
         },
    :path => "/images/:class/:id/:attachment_:style.:extension",
    :default_url  => "/images/:class/:id/:attachment/default.jpg"
    
  before_save { |media| media.permalink = media.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if media.permalink.blank?}
  before_save { |media| media.permalink = media.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if media.permalink }
  before_save :perform_remove_thumb, :perform_remove_display 
  attr_accessor :remove_thumb, :remove_display
  
  MEDIA_TYPES = ['Video', 'Audio', 'Image']
  STATUS = ['Published', 'Draft', 'Pending']
  
  validates_presence_of :title
  validates_length_of :title, :maximum => 255
  validates_presence_of :description
  validates_uniqueness_of :permalink
  validates_inclusion_of :media_type, :in => MEDIA_TYPES, 
    :media => "must be one of: #{MEDIA_TYPES.join(', ')}"
  validates_inclusion_of :status, :in => STATUS, 
    :media => "must be one of: #{STATUS.join(', ')}"
  
  scope :published, where(:status => "Published")
  scope :draft, where(:status => "Draft")
  scope :pending, where(:status => "Pending")
  scope :sorted, order('media.created_at ASC')
  scope :featured, where(:featured_media => true)
  
  def self.search(search, page)
    paginate :per_page => 10, :page => page,
               :conditions => ['title like ?', "%#{search}%"]
  end
  
  def perform_remove_thumb
    self.media_thumb = nil if self.remove_thumb=="1" && ! 
    self.media_thumb.dirty? 
    true 
  end
  
  def perform_remove_display
    self.media_display = nil if self.remove_display=="1" && ! 
    self.media_display.dirty? 
    true 
  end
  
end
