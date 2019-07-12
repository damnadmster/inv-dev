class Requirement < ApplicationRecord
  belongs_to :filial


  def self.to_csv_new(options = {})
	attributes = %w{id wishes level amount price for_what  }
    CSV.generate(options) do |csv|
	   csv << attributes
      all.each do |req|
        csv << req.attributes.values_at(*attributes).insert(-1, req.filial.name)
      end
    end
  end

end
