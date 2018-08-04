module Kf
  class AmvTopicsController < Thredded::TopicsController

    include Thredded::Engine.routes.url_helpers #.messageboards_path

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

      return render :new unless @new_topic.valid?

      if @new_topic.save
        redirect_to messageboard_topics_path(messageboard)
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
          :title,
          :locked,
          :sticky,
          :content,
          editors: [],
          sources: [],
          studios: [],
          category_ids: []
        )
        .merge(
          messageboard: messageboard,
          user: thredded_current_user,
          ip: request.remote_ip,
        ).tap { |params| params[:editors] = params[:editors].reject { |editor|
            editor.strip.empty?
          }
        }.tap { |params| params[:sources] = params[:sources].reject { |source|
            source.strip.empty?
          }
        }.tap { |params| params[:studios] = params[:studios].reject { |studio|
            studio.strip.empty?
          }
        }
    end

  end
end
