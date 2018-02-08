module Kf
  class AmvPost < ApplicationRecord
    belongs_to :post, class_name: :'Thredded::Post'

    acts_as_taggable_on :editors
    acts_as_taggable_on :sources
    acts_as_taggable_on :studios
  end
end
