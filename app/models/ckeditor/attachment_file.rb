class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attached_file :data,
                    :url => "/ckeditor_assets/pictures/:id/:filename",
                    :path => ":rails_root/public/ckeditor_assets/pictures/:id/:filename"
                    # before was attachements instead of pictures

  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 100.megabytes
  do_not_validate_attachment_file_type :data

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end

  def url_content
    if Rails.env.production?
        host_url="http://your_domen"
     else
        host_url="http://localhost:3000"
     end
    host_url+url
  end
end
