class InterestsController < ApplicationController
  include ActsAsTaggable
  before_filter :set_title, only: :show
end
