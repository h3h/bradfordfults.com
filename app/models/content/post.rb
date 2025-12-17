# frozen_string_literal: true

class Content::Post < Perron::Resource
  delegate :title, :description, :tag, :lang, :lang_ref, to: :metadata

  # Book review specific fields
  delegate :book_name, :book_author, :book_rating, :book_spoilers, to: :metadata

  def layout
    metadata.layout || "post"
  end

  def book_review?
    layout == "book_review"
  end

  def essay?
    tag == "essay"
  end

  def aside?
    tag == "aside"
  end

  def english?
    lang == "en"
  end

  def spanish?
    lang == "es"
  end

  def category
    metadata.category
  end

  def subcategory
    metadata.subcategory
  end

  # Find the translated version of this post
  def translated_post
    return nil unless lang_ref.present?

    other_lang = english? ? "es" : "en"
    Content::Post.all.find { |p| p.lang_ref == lang_ref && p.lang == other_lang }
  end

  def display_title
    book_review? ? book_name : title
  end
end
