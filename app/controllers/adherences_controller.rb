class AdherencesController < ApplicationController
  include PatientAuthenticable
  def show
    score = AdherenceCalculator.new(@patient).call
    render_success({ score: score })
  end
end
