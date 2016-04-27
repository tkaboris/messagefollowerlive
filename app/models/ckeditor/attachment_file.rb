class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attached_file :data,
                    :url => "#{host_url}/ckeditor_assets/pictures/:id/:filename",
                    :path => ":rails_root/public/ckeditor_assets/pictures/:id/:filename"
                    # before was attachements instead of pictures

  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 100.megabytes
  do_not_validate_attachment_file_type :data

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end

  def host_url
    if Rails.env.production?
      "http://your_domen"
    else
      "http://localhost:3000"
    end
  end

end
