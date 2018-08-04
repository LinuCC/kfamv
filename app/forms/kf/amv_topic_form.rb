module Kf
  class AmvTopicForm < Thredded::TopicForm

    alias_method :topic_validate_children, :validate_children
    attr_accessor :editor_list, :source_list, :studio_list

    def initialize(params = {})
      super(params)
      @editor_list = (params[:editors] || []).join(', ')
      @source_list = (params[:sources] || []).join(', ')
      @studio_list = (params[:studios] || []).join(', ')
      amv_post
    end

    def save
      return false unless valid?

      ActiveRecord::Base.transaction do
        topic.save!
        post.save!
        amv_post.save!
        Thredded::UserTopicReadState.read_on_first_post!(user, topic) if topic.previous_changes.include?(:id)
      end
      true
    end

    def amv_post
      @amv_post ||= Kf::AmvPost.new(
        editor_list: editor_list,
        source_list: source_list,
        studio_list: studio_list
      )
      post.amv_post = @amv_post
    end

    def self.from_thredded_topic_form(topic_form)
      Kf::AmvTopicForm.new(
        title: topic_form.title,
        category_ids: topic_form.category_ids,
        locked: topic_form.locked,
        sticky: topic_form.sticky,
        content: topic_form.content,
        user: topic_form.user,
        messageboard: topic_form.messageboard,
      )
    end

    def validate_children
      topic_validate_children
      promote_errors(amv_post.errors) if amv_post.invalid?
    end

  end
end
