class ConversationsController < ApplicationController

  before_filter :get_mailbox, :get_box, :get_user
  before_filter :check_current_subject_in_conversation, :only => [:show, :update, :destroy]
  load_and_authorize_resource

  def index
    if @box.eql? "inbox"
      @conversations = @mailbox.inbox
    elsif @box.eql? "sentbox"
      @conversations = @mailbox.sentbox
    elsif @box.eql? "trash"
      @conversations = @mailbox.trash
    end
  end

  def show
    if @box.eql? 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end

    # If you don't have any receipts for this conversation then this
    # is not your conversation.
    return redirect_to conversations_path if @receipts.empty?

    render :action => :show
    @receipts.mark_as_read
  end

  def update
    if params[:untrash].present?
      @conversation.untrash(current_user)
    end
    if params[:reply_all].present?
      last_receipt = @mailbox.receipts_for(@conversation).last
      @receipt = current_user.reply_to_all(last_receipt, params[:body])
    end
    if @box.eql? 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end
    redirect_to :action => :show
    @receipts.mark_as_read
  end

  def create
  end

  def reply
    current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
    redirect_to conversation
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end

  private

  def get_user
    @user = current_user
  end

  def get_mailbox
    @mailbox = current_user.mailbox
  end

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      @box = "inbox"
      return
    end
    @box = params[:box]
  end

  def check_current_subject_in_conversation
    @conversation = Conversation.find_by_id(params[:id])
    if @conversation.nil?
      redirect_to conversations_path(:box => @box)
      return
    end
  end

end