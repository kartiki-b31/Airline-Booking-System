class RenameCharactersClassColumn < ActiveRecord::Migration[7.0]
    def change
        rename_column :flights, :class, :flight_class
    end
end
