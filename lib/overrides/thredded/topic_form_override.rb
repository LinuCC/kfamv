load 'thredded/topic_form.rb'

Thredded::TopicForm.class_eval do
  def amv_topic?
    Rails.configuration.amv_messageboard_id == @messageboard.id
  end
end
