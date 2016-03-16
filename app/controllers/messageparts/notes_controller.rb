class Messageparts::NotesController < NotesController
  before_action :set_notable

  private

    def set_notable
      @notable = Messagepart.find(params[:messagepart_id])
    end
end
