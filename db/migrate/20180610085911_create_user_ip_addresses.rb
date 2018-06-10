class CreateUserIpAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :user_ip_addresses do |t|
      t.references :user, foreign_key: true
      t.references :ip_address, foreign_key: true

      t.timestamps
    end
  end
end
