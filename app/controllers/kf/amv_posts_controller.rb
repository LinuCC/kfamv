module Kf
  class AmvPostsController < Thredded::PostController

    # NOTE This controller is currently unused and untested.
    #   Here for the future. Go look at `AmvTopicsController` instead for a
    #   reference.

    def new
      @post_form = Thredded::PostForm.new(
        user: thredded_current_user, topic: parent_topic, post_params: new_post_params
      )
      authorize_creating @post_form.post
    end

    def create
      @post_form = Thredded::PostForm.new(
        user: thredded_current_user, topic: parent_topic, post_params: new_post_params
      )
      authorize_creating @post_form.post

      if @post_form.save
        redirect_to post_path(@post_form.post, user: thredded_current_user)
      else
        render :new
      end
    end

    def edit
      @post_form = Thredded::PostForm.for_persisted(post)
      authorize @post_form.post, :update?
      return redirect_to(canonical_topic_params) unless params_match?(canonical_topic_params)
      render
    end

    def update
      authorize post, :update?
      post.update(new_post_params)

      redirect_to post_path(post, user: thredded_current_user)
    end

    def destroy
      authorize post, :destroy?
      post.destroy!

      redirect_back fallback_location: topic_url(topic),
                    notice: I18n.t('thredded.posts.deleted_notice')
    end

    def new_amv_post_params
      params.fetch(:post, {})
        .permit(:content, :quote_post_id)
        .merge(ip: request.remote_ip).tap do |p|
        quote_id = p.delete(:quote_post_id)
        if quote_id
          post = Thredded::Post.find(quote_id)
          authorize_reading post
          p[:quote_post] = post
        end
      end
    end
  end
end
