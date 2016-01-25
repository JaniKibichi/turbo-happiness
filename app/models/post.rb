class Post < ActiveRecord::Base
 searchkick
 acts_as_votable
 
 extend FriendlyId
 friendly_id :title, use: :slugged

 belongs_to :user
 has_many :comments, :dependent => :destroy

  has_attached_file :image, styles: { medium: "700x500#", small: "350x250#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
