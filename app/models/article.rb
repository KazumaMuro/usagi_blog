class Article < ApplicationRecord
  mount_uploader :picture, PictureUploader

  # def before_article
  #   Article.order(created_at: :desc).where("created_at <= ?", created_at).first
  # end
  #
  # def next_article
  #   Article.order(created_at: :asc).where("created_at <= ?", created_at).first
  # end

end
