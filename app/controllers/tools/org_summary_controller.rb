# frozen_string_literal: true

class Tools::OrgSummaryController < ApplicationController
  def show
    org = Organization.find(params[:organization_id])
    session_tools = (session[:tools] || []).map { |id| Tool.find(id) }
    summary = build_summary(session_tools, org)
    render json: { summary: }
  end

  private

  def build_summary(session_tools, org)
    session_tools.map do |tool|
      tools_checked_out = Tool.checked_out_by_organization(org)
                              .where(tool_type: tool.tool_type)
      { type: tool.name, count: tools_checked_out.count, barcodes: tools_checked_out.pluck(:barcode) }
    end.uniq
  end
end
