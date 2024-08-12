# frozen_string_literal: true

module ArchiveCreation
  extend ActiveSupport::Concern

  class_methods do
    def create_from_archive(hilti_import, entry)
      puts self::CONTENT_TYPE
      filename = File.basename(entry.name)
      reference = /(\d+)/.match(filename)[1]
      record = new(hilti_import:,  reference:)
      entry.get_input_stream do |io|
        record.data.attach(io: io, filename: filename, content_type: self::CONTENT_TYPE)
        record.save!
      end
    end
  end
end
