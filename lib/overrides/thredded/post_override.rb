load 'thredded/post.rb'

Thredded::Post.class_eval do
  has_one :amv_post, class_name: :'Kf::AmvPost', dependent: :destroy

  def amv_post?
    amv_post.present?
  end
end
