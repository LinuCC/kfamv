load 'thredded/post_view.rb'

Thredded::PostView.class_eval do
  def post_instance
    @post
  end
end
