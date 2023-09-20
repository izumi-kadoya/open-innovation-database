class Record < ApplicationRecord
  mount_uploader :csv, CsvUploader
  validates :company_name, :business_partner, :article_date, presence: true
end
