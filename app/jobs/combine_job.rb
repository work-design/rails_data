class CombineJob

  def perform(combine_id)
    @combine = Combine.find(combine_id)
    @combine.run
  end

end
