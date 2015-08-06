class IssuesController < ApplicationController
  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)

    if @issue.save
      redirect_to @issue.ticket
    end
  end

  private

    def issue_params
      params.require(:issue).permit(:description)
    end
end
