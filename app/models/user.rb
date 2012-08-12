class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :username, :password_confirmation, :remember_me, :first_name, :last_name, :title, :bio, :access_level,:twitter
  
  # Blog relationships
  has_many :posts, :foreign_key => 'user_id'
  has_many :recent_posts, :class_name => 'Post', :order => 'created_at ASC', :limit => 5
  # Page relationships
  has_and_belongs_to_many :messages
  has_many :sections, :through => :section_edits
  #has_and_belongs_to_many :news
  # Media relationships
  #has_and_belongs_to_many :media
  #paperclip
  has_attached_file :avatar, :styles  => { :small => "150x150>", :medium => "300x300>", :larger => "600x600>", :thumbnail => "40x40"},
      :storage => :s3,
           :s3_credentials => {
             :bucket            => ENV['S3_BUCKET_NAME'],
             :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
             :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
           },
      :path => "/images/users/:id/:attachment_:style.:extension",
      :default_url  => "/images/users/default.jpg"

  scope :named, lambda {|first, last| where(:first_name => first, :last_name => last)}
  scope :sorted, order("users.last_name ASC, users.first_name ASC")
    
  def name
    "#{first_name} #{last_name}"
  end
  
end
