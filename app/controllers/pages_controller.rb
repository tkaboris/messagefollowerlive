class PagesController < ApplicationController

  def home
    @messages = Message.all.order("created_at DESC")

    @speakers = Speaker.all
    @sub = ListenersSpeakers.all

    #@speaker = Speaker.find(params[:id])
    # @count = @speaker.messages.count
    @listeners = Listener.all
  end
  def about

  end

  def thomas_manton

  end


end


