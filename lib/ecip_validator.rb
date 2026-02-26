# frozen_string_literal: true

require 'yaml'
require 'date'
require 'front_matter_parser'

module EcipValidator
  # Valid values based on ECIP-1000 and _data/statuses.yaml
  VALID_STATUSES = [
    'WIP', 'Draft', 'Last Call', 'Accepted', 'Final',
    'Deferred', 'Rejected', 'Withdrawn', 'Replaced', 'Superseded', 'Active'
  ].freeze

  VALID_TYPES = [
    'Standards Track', 'Informational', 'Meta'
  ].freeze

  VALID_CATEGORIES = %w[Core Networking Interface ECBP].freeze

  REQUIRED_FIELDS = %w[ecip title author type status created].freeze

  ISO8601_DATE_REGEX = /\A\d{4}-\d{2}-\d{2}\z/

  class ValidationError
    attr_reader :file, :field, :message

    def initialize(file:, field:, message:)
      @file = file
      @field = field
      @message = message
    end

    def to_s
      "#{file}: [#{field}] #{message}"
    end
  end

  class Validator
    attr_reader :file_path, :front_matter, :errors

    def initialize(file_path)
      @file_path = file_path
      @errors = []
      @front_matter = nil
    end

    def validate
      parse_front_matter
      return unless @front_matter

      validate_required_fields
      validate_status
      validate_type
      validate_category
      validate_created_date

      @errors.empty?
    end

    private

    def parse_front_matter
      content = File.read(@file_path)
      # Use custom YAML loader that permits Date class
      loader = ->(string) { YAML.safe_load(string, permitted_classes: [Date]) }
      parsed = FrontMatterParser::Parser.new(:md, loader: loader).call(content)
      @front_matter = parsed.front_matter
    rescue StandardError => e
      add_error('front_matter', "Failed to parse: #{e.message}")
      @front_matter = nil
    end

    def validate_required_fields
      REQUIRED_FIELDS.each do |field|
        value = @front_matter[field]
        if value.nil? || (value.respond_to?(:empty?) && value.empty?)
          add_error(field, 'is required but missing')
        end
      end
    end

    def validate_status
      status = @front_matter['status']
      return if status.nil?

      unless VALID_STATUSES.include?(status)
        add_error('status', "invalid value '#{status}'. Must be one of: #{VALID_STATUSES.join(', ')}")
      end
    end

    def validate_type
      type = @front_matter['type']
      return if type.nil?

      unless VALID_TYPES.include?(type)
        add_error('type', "invalid value '#{type}'. Must be one of: #{VALID_TYPES.join(', ')}")
      end
    end

    def validate_category
      type = @front_matter['type']
      category = @front_matter['category']

      if type == 'Standards Track'
        if category.nil? || category.empty?
          add_error('category', "is required when type is 'Standards Track'")
        elsif !VALID_CATEGORIES.include?(category)
          add_error('category', "invalid value '#{category}'. Must be one of: #{VALID_CATEGORIES.join(', ')}")
        end
      end
    end

    def validate_created_date
      created = @front_matter['created']
      return if created.nil?

      # Handle Date objects (YAML parser may convert dates automatically)
      if created.is_a?(Date)
        return # Valid date object
      end

      unless created.to_s.match?(ISO8601_DATE_REGEX)
        add_error('created', "invalid date format '#{created}'. Must be ISO 8601 (YYYY-MM-DD)")
      end
    end

    def add_error(field, message)
      @errors << ValidationError.new(file: @file_path, field: field, message: message)
    end
  end

  class Runner
    def self.run(files)
      valid_count = 0
      invalid_count = 0
      all_errors = []

      files.each do |file|
        validator = Validator.new(file)
        if validator.validate
          valid_count += 1
        else
          invalid_count += 1
          all_errors.concat(validator.errors)
        end
      end

      # Print results
      puts "\nECIP Validation Results"
      puts "=" * 50
      puts "Total: #{files.length}, Valid: #{valid_count}, Invalid: #{invalid_count}"

      if all_errors.any?
        puts "\nErrors:"
        all_errors.each { |error| puts "  - #{error}" }
        puts
        exit 1
      else
        puts "\nAll ECIPs are valid!"
        exit 0
      end
    end
  end
end
