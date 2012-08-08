class Upload < ActiveRecord::Base
  belongs_to :post
    has_attached_file :photo,
        :styles => {
        :small => "150x150>", :medium => "300x300>", :larger => "600x600>", :thumbnail => "40x40"},
        :storage => :s3,
             :s3_credentials => {
               :bucket            => ENV['S3_BUCKET_NAME'],
               :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
               :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
             },
        :path => "/images/:class/:year/:month/:id/:basename_:style.:extension"
end
