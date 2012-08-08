class Section < ActiveRecord::Base
  
  belongs_to :page
  has_many :section_edits
  
  has_attached_file :section_display, :styles  => { 
    :small => "260x260>", :medium => "500x500>", :large => "900x900>", :thumbnail => "126x78>"},
    :storage => :s3,
         :s3_credentials => {
           :bucket            => ENV['S3_BUCKET_NAME'],
           :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
           :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
         },
    :path => "/images/pages/:pagepath/:class/:section/:attachment_:style.:extension",
    :default_url  => "/images/pages/:class/:attachment/default.jpg"
  
  has_attached_file :section_background, :styles  => { 
    :small => "260x260>", :medium => "500x500>", :large => "900x900>", :thumbnail => "126x78>"},
    :storage => :s3,
         :s3_credentials => {
           :bucket            => ENV['S3_BUCKET_NAME'],
           :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
           :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
         },
    :path => "/images/pages/:pagepath/:class/:section/:attachment_:style.:extension",
    :default_url  => "/images/pages/:class/:attachment/default.jpg"
  
  CONTENT_TYPES = ['Text', 'HTML', 'Block']
  STATUS = ['Published', 'Draft', 'Pending']
  
  validates_presence_of :title
  validates_length_of :title, :maximum => 100
  validates_inclusion_of :content_type, :in => CONTENT_TYPES, 
    :message => "must be one of: #{CONTENT_TYPES.join(', ')}"
  validates_inclusion_of :status, :in => STATUS, 
    :message => "must be one of: #{STATUS.join(', ')}"
  validates_presence_of :content
  
  scope :published, where(:status => "Published")
  scope :draft, where(:status => "Draft")
  scope :pending, where(:status => "Pending")
  scope :sorted, order('sections.position ASC')
  
  def find_page_title
    Page.find(self.page_id).title
  end
  private
  
  Paperclip.interpolates :pagepath do |attachment, style|
    attachment.instance.find_page_title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
  Paperclip.interpolates :section do |attachment, style|
    attachment.instance.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
  
end
