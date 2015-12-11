class DeleteController < ApplicationController

  def message
    message = Message.find(params[:id])
    message.image = nil
    message.save
    redirect_to "/messages/"+message.id.to_s
  end

  def messagepart
    messagepart = Messagepart.find(params[:id])
    messagepart.image = nil
    messagepart.save
    redirect_to "/messages"
  end
end
