module Developers
  class FavActionComponent < ApplicationComponent
    attr_reader :user, :developer

    def initialize(user:, developer:)
      @user = user
      @developer = developer
    end


  end
end
