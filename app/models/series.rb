class Series < ActiveRecord::Base
  
  has_many :messages

  validates_presence_of :title
  validates_length_of :title, :maximum => 255
  validates_uniqueness_of :permalink
  
  
  has_attached_file :series_thumb, :styles  => { 
    :small => "260x260>", :medium => "500x500>", :large => "900x900>", :thumbnail => "126x78>"},
    :url => "/images/:class/:seriesname/:attachment_:style.:extension", 
    :path => ":rails_root/public/images/:class/:seriesname/:attachment_:style.:extension",
    :default_url  => "/images/series/:attachment/default.jpg"
    
   has_attached_file :series_display, :styles  => { 
    :small => "260x260>", :medium => "500x500>", :large => "900x900>", :thumbnail => "126x78>"},
    :url => "/images/:class/:seriesname/:attachment_:style.:extension", 
    :path => ":rails_root/public/images/:class/:seriesname/:attachment_:style.:extension",
    :default_url  => "/images/series/:attachment/default.jpg"
  
  before_save { |series| series.permalink = series.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if series.permalink.blank?}
  before_save { |series| series.permalink = series.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if series.permalink }  
  before_save :perform_remove_thumb, :perform_remove_display
  attr_accessor :remove_thumb, :remove_display 
  
  scope :visible, where(:visibility => true)
  scope :hidden, where(:visibility => false)
  scope :sorted, order('series.start_date ASC')
  scope :featured, where(:featured_series => true)
  
  def self.search(search, page)
    paginate :per_page => 12, :page => page,
               :conditions => ['title like ?', "%#{search}%"], :order => 'start_date DESC'
  end
  
  def perform_remove_thumb
    self.series_thumb = nil if self.remove_thumb=="1" && ! 
    self.series_thumb.dirty? 
    true 
  end
  
  def perform_remove_display
    self.series_display = nil if self.remove_display=="1" && ! 
    self.series_display.dirty? 
    true 
  end
  
  private
  
  Paperclip.interpolates :seriesname do |attachment, style|
    attachment.instance.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
  
end
