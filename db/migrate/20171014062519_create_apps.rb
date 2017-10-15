class CreateApps < ActiveRecord::Migration[5.0]
  def change
    create_table :apps do |t|
      t.string :app_name
      t.integer :req_latency
      t.integer :req_jitter
      t.integer :req_packet_drop
      t.integer :req_bw
      t.integer :company
      t.text  :remarks
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
