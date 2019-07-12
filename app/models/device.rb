require 'csv'
#require 'iconv'

class Device < ApplicationRecord
  belongs_to :filial
  belongs_to :type
  has_many :histories, :dependent => :delete_all 
  validates :name, presence: true, length: { maximum: 254 }
  #has_attached_file :image
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/missing.png", url: "/system/:hash.:extension", hash_secret: "dxI24Ydq73K8Up3r"
  validates_attachment_content_type :avatar, content_type: ["image/jpeg", "image/gif", "image/png"] , message: "wrong ext"
#  has_attached_file :actimage, styles: { thumbnail: "60x60#" }, default_url: "/missing.png", url: "/system/:hash.:extension", hash_secret: "dxI24Ydq73K8Up3r"
#  validates_attachment_content_type :actimage, content_type: "application/pdf"
#  validates :file_format, if: :media?
    has_attached_file :actimage, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/missing.png", url: "/system/:hash.:extension", hash_secret: "dxI24Ydq73K8Up3r"
    validates_attachment_content_type :actimage,  content_type: [/^image\/(jpg|jpeg|png|gif)$/, "application/pdf"] , message: "wrong ext"
#    validates_attachment_content_type :actimage, content_type:  ["image/jpeg", "image/gif", "image/png"]
#  validates_attachment :actimage,  content_type:  ["image/jpeg", "image/gif", "image/png"]
#  validates :actimage, :attachment_content_type => { :content_type => ['image/png', 'image/jpg']}


  def self.to_csv_new(options = {})
	
	attributes = %w{id name invnum serial model place iswork repair cancellation }
    CSV.generate(options) do |csv|
	   csv << attributes
      all.each do |device|
        csv << device.attributes.values_at(*attributes).insert(-1, device.filial.name).insert(-1, device.type.name)
      end
    end
  end

=begin
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |device|
        csv << device.attributes.values_at(*column_names)
      end
    end
  end
=end
  
  def file_format
    unless valid_extension? self.media.filename
      errors[:device] << "Invalid file format."
    end
  end
  def valid_extension?(filename)
    ext = File.extname(filename)
    %w( jpg jpeg png ).include? ext.downcase
  end

# /\Aimage\/.*\z/
end
