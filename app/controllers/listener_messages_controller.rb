class ListenerMessagesController < ApplicationController
  before_action :find_message, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_speaker!, except: [:index, :show]
  before_action :authenticate_listener!


  def edit
    @note_content = @note.blank? ? "" : @note.content
  end

  def update
    @note = @message.notes.create(content: params[:note], listener: current_listener) if @note.blank?
    if @note.update(content: params[:note], listener: current_listener)
      redirect_to message_path
    else
      render 'edit'
    end
  end



  private
    def message_params
      params.require(:message).permit(:note)
    end

    def find_message
      @message = Message.find(params[:id])
      @note = @message.notes.take
    end
end
