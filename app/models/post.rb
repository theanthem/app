class Post < ActiveRecord::Base
  
  # User relationships
  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id'
  # Comment relationships
  has_many :comments, :order => 'created_at ASC', :dependent => :destroy
  # Category relationships
  has_many :categorizations
  has_many :categories, :through => :categorizations
  # Images 
  has_many :uploads, :dependent => :destroy
  accepts_nested_attributes_for :uploads, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  
  acts_as_taggable
  acts_as_taggable_on :tag
  
  attr_accessible :uploads_attributes, :title, :permalink, :content, :status, :published_at, :featured_post, :tag_list
  
  attr_accessor :new_tags
  before_save { |post| post.permalink = post.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if post.permalink.blank?}
  before_save { |post| post.permalink = post.permalink.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if post.permalink }
  after_save :clear_tags
  
  has_attached_file :featured_image, :styles  => { 
    :small => "260x260>", :medium => "500x500>", :large => "900x900>", :thumbnail => "126x78>"},
    :url => "/images/:class/:year/:month/:id/:attachment_:style.:extension", 
    :path => ":rails_root/public/images/:class/:year/:month/:id/:attachment_:style.:extension",
    :default_url  => "/images/:class/:attachment/default.jpg"
  
  STATUS = ['Published', 'Draft', 'Pending']
  
  validates_presence_of :title
  validates_length_of :title, :maximum => 100

  # use presence with length to disallow spaces
  validates_uniqueness_of :permalink
  validates_presence_of :content
  validates_inclusion_of :status, :in => STATUS, 
    :message => "must be one of: #{STATUS.join(', ')}"
  # for unique values by subject, :scope => :subject_id
  
  scope :published, where(:status => "Published")
  scope :draft, where(:status => "Draft")
  scope :pending, where(:status => "Pending")
  scope :sorted, order('posts.position ASC')
  
  private
  
  def clear_tags
    # for security and b/c hashing is not needed
    self.new_tags = nil
  end
  
  Paperclip.interpolates :year do |attachment, style|
    attachment.instance.created_at.year
  end
  Paperclip.interpolates :month do |attachment, style|
    attachment.instance.created_at.month
  end
  
end
