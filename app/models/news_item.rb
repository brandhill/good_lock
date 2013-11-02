# == Schema Information
#
# Table name: news_items
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  link        :string(255)
#  publish_at  :datetime
#  raw_data    :text
#  created_at  :datetime
#  updated_at  :datetime
#  image_url   :text
#  type        :string(255)
#

class NewsItem < ActiveRecord::Base
  serialize :raw_data

  validates :link, uniqueness: true
  validates :title, :description, :link, :image_url, :publish_at, :raw_data, presence: true

  def self.search params
    if params[:begin_at].present? && params[:end_at].present?
      begin_at, end_at = Time.parse(params[:begin_at]), Time.parse(params[:end_at])
      self.where(publish_at: begin_at..end_at)
    else
      self
    end
  end

  def reload_from_raw_data!
    news_item = NewsItem.new_from_feed_item raw_data
    update news_item.attributes.except('id', 'created_at', 'updated_at')
  end
end
