class Micropost < ApplicationRecord
  belongs_to :user
  
  #Ensures that microposts will be retreived in descending order
  #The stabby lambda -> takes in a blcok and returns a Proc, which is then used by default scope
  default_scope -> { order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  
  #uses the private method created belof
  validate  :picture_size



  private
    
    # Validates the size of an uploaded picture
    def picture_size
      if picture.size > 5.megabytes
        return errors.add(:picture, "should be less than SMB")
      end
    end
end
