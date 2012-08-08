class Message < ActiveRecord::Base
  
  belongs_to :series, :counter_cache => true
  has_and_belongs_to_many :editors, :class_name => "User"
  belongs_to :speaker, :counter_cache => true
  # Alias for <tt>acts_as_taggable_on :tags</tt>:
  acts_as_taggable
  acts_as_taggable_on 
  is_impressionable
  
  has_attached_file :message_thumb, :styles  => { 
    :small => "260x260>", :medium => "500x500>", :large => "900x900>", :thumbnail => "126x78>"},
    :storage => :s3,
         :s3_credentials => {
           :bucket            => ENV['S3_BUCKET_NAME'],
           :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
           :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
         },
    :path => "/images/series/:seriespath/:class/:message/:attachment_:style.:extension",
    :default_url  => "/images/series/messages/:attachment/default.jpg"
    
   has_attached_file :message_display, :styles  => { 
    :small => "260x260>", :medium => "500x500>", :large => "900x900>", :thumbnail => "126x78>"},
    :storage => :s3,
         :s3_credentials => {
           :bucket            => ENV['S3_BUCKET_NAME'],
           :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
           :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
         },
    :path => "images/series/:seriespath/:class/:message/:attachment_:style.:extension",
    :default_url  => "/images/series/messages/:attachment/default.jpg"
  
  before_save { |message| message.permalink = message.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if message.permalink.blank?}
  before_save { |message| message.permalink = message.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if message.permalink }
  before_save :perform_remove_thumb, :perform_remove_display 
  attr_accessor :remove_thumb, :remove_display
  
  STATUS = ['Published', 'Draft', 'Pending']
  
  validates_presence_of :title
  validates_length_of :title, :maximum => 255
  validates_inclusion_of :status, :in => STATUS, 
    :message => "must be one of: #{STATUS.join(', ')}"
  validates_uniqueness_of :permalink
  
  scope :published, where(:status => "Published")
  scope :draft, where(:status => "Draft")
  scope :pending, where(:status => "Pending")
  scope :sorted, order('messages.air_date ASC')
  scope :featured, where(:featured_message => true)
  
  def self.search(search, page)
    paginate :per_page => 10, :page => page,
               :conditions => ['title like ?', "%#{search}%"], :order => 'air_date'
  end
  
  def perform_remove_thumb
    self.message_thumb = nil if self.remove_thumb=="1" && ! 
    self.message_thumb.dirty? 
    true 
  end
  
  def perform_remove_display
    self.message_display = nil if self.remove_display=="1" && ! 
    self.message_display.dirty? 
    true 
  end
  
  def find_series_title
    Series.find(self.series_id).title
  end
  private
  
  Paperclip.interpolates :seriespath do |attachment, style|
    attachment.instance.find_series_title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
  Paperclip.interpolates :message do |attachment, style|
    attachment.instance.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
  
end
