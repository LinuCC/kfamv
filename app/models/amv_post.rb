class AmvPost < ApplicationRecord
  belongs_to :post, class_name: :'Thredded::Post'
end
