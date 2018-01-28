module Thredded
  Post.class_eval do
    has_one :amv_post, class_name: :'Kf::AmvPost', dependent: :destroy
  end
end
