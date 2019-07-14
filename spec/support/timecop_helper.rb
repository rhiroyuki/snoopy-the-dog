# frozen_string_literal: true

module TimeHelpers
  def freeze_time(datetime)
    Timecop.freeze(datetime)
  end

  def unfreeze_time
    Timecop.return
  end
end
