class ListenerMessagepartsController < ApplicationController
  before_action :find_message
  before_action :find_messagepart, only: [:edit, :update, :destroy]
  # before_action :authenticate_speaker!, except: [:index, :show]
  before_action :authenticate_listener!

  def edit
    @note_content = @note.blank? ? "" : @note.content
  end

  def update
    @note = @messagepart.notes.create(content: params[:note], listener: current_listener) if @note.blank?
    if @note.update(content: params[:note], listener: current_listener)
      redirect_to message_path
    else
      render 'edit'
    end
  end


  private
    def messagepart_params
      params.require(:messagepart).permit(:notes)
    end

    def find_message
      @message = Message.find_by(id: params[:listener_message_id])
    end

    def find_messagepart
      @messagepart = Messagepart.find(params[:id])
      @note = @messagepart.notes.take
    end


end
