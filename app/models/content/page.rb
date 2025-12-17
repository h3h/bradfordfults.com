# frozen_string_literal: true

class Content::Page < Perron::Resource
  delegate :title, :description, :lang, :lang_ref, :topic, :body_class, :salutation, to: :metadata

  def english?
    lang.nil? || lang == "en"
  end

  def spanish?
    lang == "es"
  end

  # Find the translated version of this page
  def translated_page
    return nil unless lang_ref.present?

    other_lang = english? ? "es" : "en"
    Content::Page.all.find { |p| p.lang_ref == lang_ref && p.lang == other_lang }
  end
end
