class CommentsController < ApplicationController

  load_and_authorize_resource
  before_filter :authenticate_user!

  # POST /trips/1/comments
  # POST /trips/1/comments.json
  def create

    @trip = Trip.find(params[:trip_id])
    @comment = @trip.comments.create(comment_parameters)
    @comment.title = @trip.name
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @trip, notice: 'Comment was successfully added.' }
        format.json { render json: @trip, status: :created, location: @trip }
      else
        format.html { redirect_to @trip, notice: 'There was an error saving your comment' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def comment_parameters
    params.require(:comment).permit(:trip_id, :comment, :name)
  end

end
