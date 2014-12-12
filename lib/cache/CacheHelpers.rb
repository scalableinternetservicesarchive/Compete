module CacheHelper
  def cache_key_for_challenge
    count          = Challenge.count
    max_updated_at = Challenge.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "challenge/all-#{count}-#{max_updated_at}"
  end
end


