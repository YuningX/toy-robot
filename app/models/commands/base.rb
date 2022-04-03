module Commands
  class Base
    include ActiveModel::Validations

    attr_reader :original_command

    validates! :original_command, presence: true
    validate :validate_command

    def run(**_args)
      raise StandardError, 'process_command is not implemented'
    end

    def initialize(**args)
      @original_command = args[:original_command]
      valid?
    end

    def validate_command; end
  end
end
