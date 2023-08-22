class CheerReactionsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @cheer = Cheer.find(params[:cheer_id])
    reaction = @cheer.cheer_reactions.new(reaction_params)
    reaction.user = current_user
    reaction.save
    @cheer_reaction = CheerReaction.new
    if @cheer.user != current_user
      @notification = Notification.create(user: @cheer.user, subjectable: reaction)
      @notification.broadcast_prepend_to("notifications-for-#{@cheer.user.id}")
    end
  end

  def destroy
    @cheer = Cheer.find(params[:cheer_id])
    reaction = @cheer.cheer_reactions.find(params[:id])
    reaction.destroy
    @cheer_reaction = CheerReaction.new
    @cheer.broadcast_replace_to("cheers-of-#{params[:post_id]}")
  end

  def index
    @cheer = Cheer.find(params[:cheer_id])
  end

  private def reaction_params
    params.require(:cheer_reaction).permit(:body)
  end
end
