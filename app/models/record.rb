class Record < ApplicationRecord
  mount_uploader :csv, CsvUploader
  validates :company_name, presence: true
end
