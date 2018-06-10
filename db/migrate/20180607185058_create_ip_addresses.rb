class CreateIpAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :ip_addresses do |t|
      t.string :address, index: true
      t.boolean :suspicious, default: false

      t.timestamps
    end
  end
end
