class CommentsController < ApplicationController

  before_filter :authenticate_user!

  # POST /trips/1/comments
  # POST /trips/1/comments.json
  def create

    @trip = Trip.find(params[:trip_id])
    @comment = @trip.comments.create(:title => @trip.name, :comment => params[:comment][:comment])
    @comment.title = @trip.name
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        CommentMailer.comment_email(@comment, @trip).deliver
        format.html { redirect_to @trip, notice: 'Comment was successfully added.' }
        format.json { render json: @trip, status: :created, location: @trip }
      else
        format.html { redirect_to @trip, notice: 'There was an error saving your comment' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

end
