class MessagesController < ApplicationController
  before_filter :get_mailbox, :get_box, :get_user

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
      @recipient = current_user.find_by_slug(params[:receiver])
      return if @recipient.nil?
    end
  end

  def edit
  end

  def create  
    @recipients = Array.new
    recipient_emails = params[:recipients].split(',')
    recipient_emails.each do |recipient|
      r = User.find_by_email(recipient)
      next if r.nil?
      @recipients << r
    end  
    @recipients = @recipients.uniq
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
    
end
