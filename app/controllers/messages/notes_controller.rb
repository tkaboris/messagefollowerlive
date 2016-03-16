class Messages::NotesController < NotesController
  before_action :set_notable

  private

    def set_notable
      @notable = Message.find(params[:message_id])
    end
end
