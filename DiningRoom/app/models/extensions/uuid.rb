module Extensions
  module UUID
    extend ActiveSupport::Concern
    included do
      validates_uniqueness_of :id
      after_initialize :generate_id

      def generate_id
        self.id = SecureRandom.uuid if self.respond_to?(:id) && self.send(:id).nil?
      end


    end
  end
end
