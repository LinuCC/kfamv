module Kf
  class AmvTopicsController < Thredded::TopicsController

    def new
      @new_topic = Kf::AmvTopicForm.new(new_topic_params)
      authorize_creating @new_topic.topic
      redirect_path = Thredded::Engine.routes.url_helpers.canonical_messageboard_params
      return redirect_to(redirect_path) unless params_match?(redirect_path)
      render
    end

    def create
      @new_topic = Kf::AmvTopicForm.new(new_topic_params)
      authorize_creating @new_topic.topic
      if @new_topic.save
        redirect_to Thredded::Engine.routes.url_helpers.messageboard_topics_path(messageboard)
      else
        render :new
      end
    end

    def messageboard
      Thredded::Messageboard.find(Rails.configuration.amv_messageboard_id)
    end

    def new_topic_params
      params
        .fetch(:topic, {})
        .permit(
          :title, :locked, :sticky, :content, editors: [], category_ids: []
        )
        .merge(
          messageboard: messageboard,
          user: thredded_current_user,
          ip: request.remote_ip,
        ).tap { |params| params[:editors] = params[:editors].reject { |editor|
            editor.strip.empty?
          }
        }
    end

  end
end
