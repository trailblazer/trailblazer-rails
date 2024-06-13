class Song < ApplicationRecord

  def inspect
    # this makes the output consistent across Ruby versions
    title = self.title.present? ? "\"#{self.title}\"" : "nil"
    id = self.id.present? ? self.id : "nil"
    %{#<Song id: #{id}, title: #{title}>}
  end
end
