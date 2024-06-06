# frozen_string_literal: true

class BulletinsController < ApplicationController
  # BEGIN

  def index
    @items = Bulletin.all
  end

  def show
    @item = Bulletin.find(params[:id])
  end

  # END
end
