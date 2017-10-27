class Company < ActiveRecord::Base
  has_many  :apps #, dependent: :destroy

  #validates :company_name, presence: true

end
