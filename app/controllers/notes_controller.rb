class NotesController < ApplicationController
before_action :find_notes, only: [:show, :edit, :update, :destroy]
before_action :authenticate_listener!

  def new
    @note = Note.new
  end

  def index
    @notes = Note.all
  end

  def show
    @note = Note.find(params[:id])
  end

  def create

    # @notable = find_notable
    # @note = @notable.notes.build(notes_params)
    @note = @notable.notes.new notes_params
    @note.listener = current_listener
    @note.save
    redirect_to @notable, notice: "your note sas saved"

    # if @note = Note.create(notes_params)
    #   redirect_to notes_path
    # end

  end

  private
    def notes_params
      params.require(:note).permit(:content)
    end

    def find_notes
      @note = Note.find(params[:id])
    end


end
