class Setting::CustomBanner < ::Setting
  def self.load_defaults
    return unless ActiveRecord::Base.connection.table_exists?('settings')
    return unless super

    Setting.transaction do
      [
        self.set('custom_banner_text', N_('Text to set on the custom banner'), 
          'Configure the custom banner in your Foreman settings!'),
        self.set('custom_banner_enabled', N_('Whether to enable the custom banner'), true),
        self.set('custom_banner_style', N_('CSS styling for the custom banner'),
          'text-align:center;background-color:green;color:white;font-weight:bold;'),
      ].compact.each { |s| self.create! s.update(:category => "Setting::CustomBanner") }
    end

    true
  end
end
