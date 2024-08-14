# frozen_string_literal: true

class InspectionTemplate
  attr_reader :fields, :lists

  def initialize(fields:, lists:)
    @fields = fields
    @lists = lists
  end

  def self.from_json(json)
    fields = json["fields"].select { |f| !(%w(feature guidance).include? f["type"]) }.map do |field|
      field
    end

    lists = json["lists"].map do |key, list|
      list
    end

    new fields:, lists:
  end
end
