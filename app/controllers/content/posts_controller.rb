# frozen_string_literal: true

class Content::PostsController < ApplicationController
  def index
    @posts = Content::Post.all.select(&:published?)
  end

  def show
    @resource = Content::Post.find(params[:id].force_encoding("UTF-8"))
  end
end
