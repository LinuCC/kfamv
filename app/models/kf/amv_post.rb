module Kf
  class AmvPost < ApplicationRecord
    belongs_to :post, class_name: :'Thredded::Post'

    acts_as_taggable_on :editors
    acts_as_taggable_on :sources
    acts_as_taggable_on :studios

    validate do |amv_post|
      if !amv_post.validate_tag_present? :editor
        amv_post.errors[:editors] << 'Please specify at least one editor'
      end
      if !amv_post.validate_tag_present? :source
        amv_post.errors[:sources] << 'Please specify at least one source'
      end
      if !amv_post.validate_tag_present? :studio
        amv_post.errors[:studios] << 'Please specify at least one studio'
      end
    end

    def validate_tag_present?(tag_name)
      return (
        self.send("#{tag_name}_list_change").kind_of?(Array) &&
        self.send("#{tag_name}_list_change")[1].size != 0
      )
    end
  end
end
