class App < ActiveRecord::Base
validates  :app_name, uniqueness: true
#  validate  :app_id, presence: true

  def self.import(file)

    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    app = find_by(app_name: row["app_name"]) || new
    app.attributes = row.to_hash.slice(*updatable_attributes)
    app.save!
    end
  end

  def self.updatable_attributes
    ["app_name","req_latency","req_jitter","eq_packet_drop","req_bw","remarks"]
  end

end
