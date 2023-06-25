class CreateProducts < Jennifer::Migration::Base
  def up
    create_table :products do |t|
      t.string :name, {:null => false}
      t.double :price, {:null => false}

      t.timestamps
    end
  end

  def down
    drop_table :products if table_exists? :products
  end
end
