class App < ActiveRecord::Base

 require 'csv'

 belongs_to :user
 validates  :app_name, uniqueness: true
 validates  :user_id, presence: true

  def self.import(file, current_user)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    app = find_by(app_name: row["app_name"]) || new
    app.attributes = row.to_hash.slice(*updatable_attributes)
    app.user_id = current_user.id
    app.save!
    end
  end

  def self.to_csv(options = {})
    desired_columns = [*exportable_attributes]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |a|
        csv << a.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.updatable_attributes
    ["app_name","req_latency","req_jitter","req_packet_drop","req_bw","remarks","user_id"]
  end

  def self.exportable_attributes
    ["app_name","req_latency","req_jitter","req_packet_drop","req_bw","remarks"]
  end

  def self.search(term)
    if term
      where(['app_name LIKE ?', "%#{term}%"])
    else
      all
    end
  end

end
