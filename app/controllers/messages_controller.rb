class MessagesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_mailbox, :get_box, :get_user, :get_unread_count_from_inbox

  def index
    redirect_to conversations_path(:box => @box)
  end

  def show
    if @message = Message.find_by_id(params[:id]) and @conversation = @message.conversation
    end
    redirect_to conversations_path(:box => @box)
  end

  def new
    if params[:receiver].present?
      @recipient = User.find_by_profile_id(params[:receiver]).id
      return if @recipient.nil?
    end
  end

  def edit
  end

  def create  
    @recipients = Array.new
    @recipients << User.find_by_id(params[:receiver])
    @receipt = current_user.send_message(@recipients, params[:body], params[:subject])

    if (@receipt.errors.blank?)
      @conversation = @receipt.conversation
      flash[:success]= 'Message sent'
      redirect_to conversation_path(@conversation, :box => :sentbox)
    else
      render :action => :new
    end
  end

  def update
  end

  def destroy
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

  def get_unread_count_from_inbox
    @unread_count = @mailbox.inbox({:read => false}).count
  end

end
