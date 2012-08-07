class Upload < ActiveRecord::Base
  belongs_to :post
    has_attached_file :photo,
                      :styles => {
                        :small => "150x150>", :medium => "300x300>", :larger => "600x600>", :thumbnail => "40x40"},
                        :url => "/images/:class/:year/:month/:id/:basename_:style.:extension", 
                        :path => ":rails_root/public/images/:class/:year/:month/:id/:basename_:style.:extension"
end
