class Type < ApplicationRecord
  has_many :devices, :dependent => :delete_all 
end
