class AddSecondLetterToWord < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :secondLetter, :string
  end
end
