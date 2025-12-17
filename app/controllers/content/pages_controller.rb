# frozen_string_literal: true

class Content::PagesController < ApplicationController
  include Perron::Root

  def show
    @resource = Content::Page.find(params[:id])
  end
end
