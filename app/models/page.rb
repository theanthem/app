class Page < ActiveRecord::Base
  
  has_and_belongs_to_many :editors, :class_name => "User"
  has_many :sections, :dependent => :destroy
  accepts_nested_attributes_for :sections, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  
  attr_accessible :sections_attributes, :name, :permalink, :status, :visibility, :published_at, :template, :position, :parent_id
  
  has_attached_file :page_thumbnail, :styles  => { 
    :small => "260x260>", :medium => "500x500>", :large => "900x900>", :thumbnail => "126x78>"},
    :storage => :s3,
         :s3_credentials => {
           :bucket            => ENV['S3_BUCKET_NAME'],
           :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
           :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
         },
    :path => "/images/:class/:pagename/:attachment_:style.:extension",
    :default_url  => "/images/:class/:attachment/default.jpg"
                                                                           
  has_attached_file :page_display, :styles  => { 
    :small => "260x260>", :medium => "500x500>", :large => "900x900>", :thumbnail => "126x78>"},
    :storage => :s3,
         :s3_credentials => {
           :bucket            => ENV['S3_BUCKET_NAME'],
           :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
           :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
         },
    :path => "/images/:class/:pagename/:attachment_:style.:extension",
    :default_url  => "/images/:class/:attachment/default.jpg"
  
  has_attached_file :page_background, :styles  => { 
    :small => "260x260>", :medium => "500x500>", :large => "900x900>", :thumbnail => "126x78>"},
    :storage => :s3,
         :s3_credentials => {
           :bucket            => ENV['S3_BUCKET_NAME'],
           :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
           :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
         },
    :path => "/images/:class/:pagename/:attachment_:style.:extension",
    :default_url  => "/images/:class/:attachment/default.jpg"
    
  acts_as_nested_set
  
  def self.search(search, page)
    paginate :per_page => 10, :page => page,
               :conditions => ['name like ?', "%#{search}%"], :order => 'position'
  end
  
  before_save { |page| page.permalink = page.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if page.permalink.blank?}
  before_save { |page| page.permalink = page.permalink.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if page.permalink }
    
  TEMPLATES = ['Basic', 'Special', 'Custom']
  STATUS = ['Published', 'Draft', 'Pending']
  VISIBILITY = ['Visible', 'Hidden', 'Staff']

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  # use presence with length to disallow spaces
  validates_uniqueness_of :permalink
  validates_inclusion_of :template, :in => TEMPLATES, 
    :message => "must be one of: #{TEMPLATES.join(', ')}"
  validates_inclusion_of :status, :in => STATUS, 
    :message => "must be one of: #{STATUS.join(', ')}"
  
  scope :published, where(:status => "Published")
  scope :draft, where(:status => "Draft")
  scope :pending, where(:status => "Pending")
  scope :visibility, where(:status => "Visibility")
  scope :hidden, where(:status => "Hidden")
  scope :staff, where(:status => "Staff")
  scope :sorted, order('pages.position ASC')
  
  private
  
  def position_scope
    "pages.parent_id = #{parent_id.to_i}"
  end
  
  Paperclip.interpolates :pagename do |attachment, style|
    attachment.instance.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
  
end
