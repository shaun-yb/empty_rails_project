require 'pry'
class Url < ApplicationRecord

  URL_REGEX = /[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)/
  SLUG_REGEX = /^[a-zA-Z0-9]+$/

  before_save :prepend_path_with_protocol_if_missing
  validates :path, format: { with: URL_REGEX }

  # TODO: Put this in the UrlHelper module
  def self.valid_slug?(slug)
    !!(slug.match(SLUG_REGEX))
  end

  protected

  def prepend_path_with_protocol_if_missing
    unless self.path[/\Ahttp:\/\//] || self.path[/\Ahttps:\/\//]
      self.path = "http://#{self.path}"
    end
  end

  # Take in a given URL and determine if it is a valid URL
  # Input [String] url
  # Output [Boolean]
  def self.valid_url?(url)
    !!(url.match(URL_REGEX))
  end
end
