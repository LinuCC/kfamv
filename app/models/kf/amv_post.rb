require 'overrides/thredded/post'

module Kf
  class AmvPost < ApplicationRecord
    belongs_to :post, class_name: :'Thredded::Post'

    acts_as_taggable_on :editors
  end
end
