# frozen_string_literal: true

class EnableUuidPsqlExtension < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto'
    enable_extension 'uuid-ossp'
  end
end
