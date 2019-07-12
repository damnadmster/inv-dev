class Filial < ApplicationRecord
    has_many :users, :dependent => :delete_all 
    has_many :people, :dependent => :delete_all 
    has_many :devices, :dependent => :delete_all 
    has_many :requirements, :dependent => :delete_all 



end
