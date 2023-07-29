class CommentReactionsController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    reaction = @comment.comment_reactions.new(reaction_params)
    reaction.user = current_user
    reaction.save
    @comment_reaction = CommentReaction.new
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    reaction = @comment.comment_reactions.find(params[:id])
    reaction.destroy
    @comment_reaction = CommentReaction.new
  end

  private def reaction_params
    params.require(:comment_reaction).permit(:body)
  end
end
