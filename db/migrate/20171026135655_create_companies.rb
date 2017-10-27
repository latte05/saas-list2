class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.text  :company_url
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
