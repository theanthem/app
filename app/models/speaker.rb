class Speaker < ActiveRecord::Base
  
  has_many :messages
  
  has_attached_file :photo, :styles  => { :small => "150x150>", :medium => "300x300>", :larg => "600x600>", :thumbnail => "40x40"},
      :storage => :s3,
           :s3_credentials => {
             :bucket            => ENV['S3_BUCKET_NAME'],
             :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
             :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
           },
      :path => :path_by_name,
      :default_url  => "/images/speakers/default.jpg"
  validates_attachment_presence :photo  
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  scope :sorted, order('speaker.last_name ASC')
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def self.search(search, page)
    paginate :per_page => 12, :page => page,
               :conditions => ["first_name like ?", "%#{search}%"], :order => 'last_name ASC, first_name ASC'
  end
  
  private
  
  def path_by_name
    "/images/speakers/:id/#{first_name.downcase}#{last_name.downcase}_:style.:extension"
  end
  
end
