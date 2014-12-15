module ChallengesHelper

  def cache_key_for_challenges
    chal_count =Challenge.count
    par_count =Participation.count
    par_max = Participation.maximum(:updated_at).try(:utc).try(:to_s, :number)
    max_updated_at = Challenge.maximum(:updated_at).try(:utc).try(:to_s, :number)

    "challenge/all-#{chal_count}-#{max_updated_at}-#{par_max}-#{par_count}"
  end

  end
